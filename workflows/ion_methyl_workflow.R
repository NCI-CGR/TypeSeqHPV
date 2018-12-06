#### A. load packages ####
library(devtools)
library(TypeSeqHPV)
library(tidyverse)
library(igraph)
library(jsonlite)
library(parallel)
library(rmarkdown)
library(furrr)
library(future)
library(drake)
library(fs)

#### B. create workflow plan ####
pkgconfig::set_config("drake::strings_in_dots" = "literals")
ion_plan <- drake::drake_plan(

#### 1. get command line arguments ####
args_df = methyl_command_line_args() %>%
    glimpse(),

#### 1. parse plugin data ####
user_files = methyl_startplugin_parse(args_df),

#### 2. demux bams ####
demux_bams = adam_demux(user_files) %>%
    glimpse(),

#### 3. picard sort and create index ####
sorted_bams = demux_bams %>%
    split(.$path) %>%
    future_map_dfr(samtools_sort) %>%
    glimpse(),

#### 4. run tvc on demux bams ####
vcf_files = sorted_bams %>%
    select(path = sorted_path) %>%
    split(.$path) %>%
    future_map_dfr(tvc_cli, args_df) %>%
    glimpse(),

#### 5. vcf to json adam ####
vcf_to_json_files = vcf_files %>%
    vcf_to_json() %>%
    glimpse(),

#### 5. vcf to json adam ####
hotspot_df = vcf_to_json_files %>%
    group_by(path) %>%
    do({
        temp = as_tibble(.)

        temp = flatten(stream_in(file(temp$path))) #%>%
            #mutate(filtersFailed = unlist(filtersFailed))

    }) %>%
    filter(annotation.attributes.HS == "true") %>%
    ungroup() %>%
    rename(sample_name = path) %>%
    mutate(sample_name = str_sub(sample_name, start = 5, end = 10)) %>%
    glimpse() %>%
    select_if(negate(is.list)) %>%
    write_csv("hotspot_variants_table.csv")

)

#### C. execute workflow plan ####
if ( args_is_torrent_server == "yes") { setwd("/mnt")}

system("mkdir sorted_bams")
system("mkdir vcf")

future::plan(multiprocess)
drake::make(ion_plan)

#### E. make html block for torrent server ####
html_block = if ( args_is_torrent_server == "yes") {
    render("/TypeSeqHPV/inst/methylation/torrent_server_html_block.R",
           output_dir = "/mnt")}else{"not torrent server"}


