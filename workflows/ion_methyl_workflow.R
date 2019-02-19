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
    config_file = optigrab::opt_get('config_file'),
    ram = optigrab::opt_get('ram'),
    cores = optigrab::opt_get('cores')) %>%
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
demux_bams = adam_demux(user_files, args_df$ram, args_df$cores) %>%
    glimpse(),

#### 4. picard sort and create index ####
sorted_bams = demux_bams %>%
     split(.$path) %>%
     future_map_dfr(samtools_sort) %>%
     glimpse()
,

#### 5. run tvc on demux bams ####
vcf_files = sorted_bams %T>%
    map_df(~ system(paste0("cp ", args_df$reference, " ./"))) %T>%
    map_df(~ system(paste0("samtools faidx ", basename(args_df$reference)))) %>%
    #select(path = sorted_path) %>%
    split(.$barcode) %>%
    future_map_dfr(tvc_cli, args_df) %>%
    glimpse(),

#### 6. merge vcf files in to 1 table ####
variant_table = vcf_files %>%
     split(.$vcf) %>%
     future_map_dfr(vcf_to_dataframe) %>%
     mutate(barcode = str_sub(filename, 5, 10)) %>%
     glimpse(),

#### 7. joing variant table with sample sheet and write to file ####
variant_table_join = user_files$manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    left_join(variant_table) %>%
    select(-filename, -BC1, -BC2) %>%
    glimpse() %>%
    write_csv("variant_table.csv")
)
#### C. execute workflow plan ####
system("mkdir sorted_bams")
system("mkdir vcf")

future::plan(multiprocess)
drake::make(ion_plan)

#### E. make html block for torrent server ####
html_block = if ( command_line_args$is_torrent_server == "yes") {
    render("/TypeSeqHPV/inst/methylation/torrent_server_html_block.R",
           output_dir = "./")}


