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
library(magrittr)

command_line_args = tibble(
    manifest = optigrab::opt_get('manifest'),
    control_definitions = optigrab::opt_get('control_definitions'),
    control_freq = optigrab::opt_get('control_freq'),
    barcode_file = optigrab::opt_get('barcode_file'),
    pn_filters = optigrab::opt_get('pn_filters'),
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
args_df = get_command_line_args(command_line_args) %>%
    glimpse(),

#### 2. parse plugin data ####
user_files = meth_startplugin_parse(args_df) %>%
  glimpse(),

#### 3. demux bams ####
demux_bam = dir_ls("./", recursive = T, glob = "*bam*") %>% 
  map_df(as_tibble)  %>% 
  rename(sorted_path = value) %>% 
  mutate(path = sorted_path) %>% 
  separate(path, c("a","b","c")) %>% 
  mutate(bam_path = paste0(a,"_",b,"_",c,".bam")) %>% 
  mutate(sample = b),

#### 4. split, sort, and index bams ####
sorted_bam = demux_bam %>% 
   split(.$bam_path) %>% 
   future_map_dfr(single_barcode_demux) %>% 
   glimpse(),

#### 5. run tvc on demux bams ####
vcf_files = demux_bam %T>%
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
    mutate(barcode = str_sub(filename, 5, 7)) %>%
    glimpse(),

#### 7. joining variant table with sample sheet and write to file ####
variants_final_table = single_bar_methyl_variant_filter(variant_table,
                                      args_df$filteringTable,
                                      args_df$posConversionTable,
                                      args_df$pn_filters,
                                      user_files$manifest,
                                      user_files$control_definitions, 
                                      user_files$control_freq) %T>%
  map_df(~ system("zip -j TypeSeqHPVMethyl_outputs.zip read_summary.csv *results.csv"))

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


