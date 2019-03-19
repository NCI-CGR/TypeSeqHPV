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
library(optigrab)

command_line_args = tibble(
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
    cores = optigrab::opt_get('cores'),
    tvc_cores = optigrab::opt_get('tvc_cores'),
    filteringTable = optigrab::opt_get('filteringTable'),
    posConversionTable = optigrab::opt_get('posConversionTable')) %>%
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
demux_bam = adam_demux(user_files, args_df$ram, args_df$cores) %>%
    glimpse(),

#### 4. split, sort, and index bams ####
sorted_bam = demux_bam %>%
    split(.$sample) %>%
    future_map_dfr(samtools_sort) %>%
    glimpse(),

#### 5. run tvc on demux bams ####
vcf_files = sorted_bam %T>%
    map_df(~ system(paste0("cp ", args_df$reference, " ./"))) %T>%
    map_df(~ system(paste0("samtools faidx ", basename(args_df$reference)))) %>%
    split(.$sample) %>%
    future_map_dfr(tvc_cli, args_df) %>%
    glimpse(),

#### 6. merge vcf files in to 1 table ####
variant_table = vcf_files %>%
    filter(file_exists(vcf_out)) %>%
    split(.$vcf_out) %>%
    future_map_dfr(vcf_to_dataframe) %>%
    glimpse() %>%
    mutate(barcode = str_sub(filename, 5, 10)) %>%
    glimpse(),

#### 7. joining variant table with sample sheet and write to file ####
variants_final = methyl_variant_filter(variant_table,
                                      args_df$filteringTable,
                                      args_df$posConversionTable,
                                      user_files$manifest,
                                      user_files$control_definitions)
)

#### C. execute workflow plan ####
system("mkdir vcf")

future::plan(multiprocess)

num_cores = availableCores() - 1
future::plan(multicore, workers = num_cores)

drake::make(ion_plan)

#### E. make html block for torrent server ####
html_block = if ( command_line_args$is_torrent_server == "yes") {
    render("/TypeSeqHPV/inst/methylation/torrent_server_html_block.R",
           output_dir = "./")}


