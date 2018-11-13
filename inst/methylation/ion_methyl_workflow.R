#### A. load packages ####
library(devtools)
library(TypeSeqHPV)
library(optigrab)
library(tidyverse)
library(igraph)
library(jsonlite)
library(parallel)
library(rmarkdown)
library(furrr)
library(future)
library(drake)
library(fs)

setwd("/mnt")

#### B. get command line arguments ####
args_is_torrent_server = optigrab::opt_get('is_torrent_server')
args_start_plugin = optigrab::opt_get('start_plugin')

#### C. create workflow plan ####
pkgconfig::set_config("drake::strings_in_dots" = "literals")
ion_plan <- drake::drake_plan(

#### 1. parse plugin data ####
parse_plugin = if (args_is_torrent_server == "yes") {
    methyl_startplugin_parse(args_start_plugin)
    },

#### 2. demux bams ####
demux_bams = adam_demux(parse_plugin, args_bam_files_dir) %>%
    glimpse(),

#### 3. picard sort and create index ####
sorted_bams = demux_bams %>%
    split(.$path) %>%
    future_map_dfr(samtools_sort) %>%
    glimpse(),

#### 4. run tvc on demux bams ####
run_tvc = sorted_bams %>%
    #slice(1:1) %>%
    select(path = sorted_path) %>%
    split(.$path) %>%
    future_map_dfr(tvc_cli) %>%
    glimpse(),

#### 5. vcf to json adam ####
vcf_to_json_files = run_tvc %>%
    vcf_to_json() %>%
    glimpse(),

#### 5. vcf to json adam ####
vcf_json_to_df = vcf_to_json_files %>%
    group_by(path) %>%
    do({
        temp = as_tibble(.)

        temp = flatten(stream_in(file(temp$path))) #%>%
            #mutate(filtersFailed = unlist(filtersFailed))

    }) %>%
    glimpse() %>%
    select_if(negate(is.list)) %>%
    write_csv("hotspot_variants_table.csv")


)

#### D. execute workflow plan ####
if ( args_is_torrent_server == "yes") { setwd("/mnt")}

system("mkdir sorted_bams")
system("mkdir vcf")


future::plan(multiprocess)
drake::make(ion_plan)

#### E. make html block for torrent server ####
html_block = if ( args_is_torrent_server == "yes") {
    render("/TypeSeqHPV/inst/methylation/torrent_server_html_block.R",
           output_dir = "/mnt")}else{"not torrent server"}


