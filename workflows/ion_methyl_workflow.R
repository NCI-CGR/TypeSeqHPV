#### A. load packages ####
library(TypeSeqHPV)
library(drake)
library(tidyverse)
library(parallel)
library(rmarkdown)
library(furrr)
library(future)
library(fs)
library(jsonlite)

command_line_args = data_frame(
    manifest = optigrab::opt_get('manifest'),
    control_definitions = optigrab::opt_get('control_definitions'),
    barcode_file = optigrab::opt_get('barcode_file'),
    tvc_parameters = optigrab::opt_get('tvc_parameters'),
    reference = optigrab::opt_get('reference'),
    region_bed = optigrab::opt_get('region_bed'),
    hotspot_vcf = optigrab::opt_get('hotspot_vcf'),
    is_torrent_server = optigrab::opt_get('is_torrent_server'),
    start_plugin = optigrab::opt_get('start_plugin'),
    config_file = optigrab::opt_get('config_file')) %>%
    glimpse()

#### B. create workflow plan ####
pkgconfig::set_config("drake::strings_in_dots" = "literals")
ion_plan <- drake::drake_plan(

#### 1. adjust command line arguments ####
args_df = methyl_command_line_args(command_line_args) %>%
    glimpse(),

#### 2. parse plugin data ####
user_files = methyl_startplugin_parse(args_df),

#### 3. demux bams ####
demux_bams = adam_demux(user_files) %>%
    glimpse(),

#### 4. picard sort and create index ####
sorted_bams = demux_bams %>%
    split(.$path) %>%
    future_map_dfr(samtools_sort) %>%
    glimpse(),

#### 5. run tvc on demux bams ####
vcf_files = sorted_bams %T>%
    map_df(~ system(paste0("cp ", args_df$reference, " ./"))) %T>%
    map_df(~ system(paste0("samtools faidx ", basename(args_df$reference)))) %>%
    select(path = sorted_path) %>%
    split(.$path) %>%
    future_map_dfr(tvc_cli, args_df) %>%
    glimpse(),

#### 6. vcf to json adam ####
vcf_to_json_files = vcf_files %>%
    vcf_to_json() %>%
    glimpse(),

#### 7. merge json files in to 1 table ####
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
system("mkdir sorted_bams")
system("mkdir vcf")

future::plan(multiprocess)
drake::make(ion_plan)

#### E. make html block for torrent server ####
html_block = if ( command_line_args$is_torrent_server == "yes") {
    render("/TypeSeqHPV/inst/methylation/torrent_server_html_block.R",
           output_dir = "/mnt")}


