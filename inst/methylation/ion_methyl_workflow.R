#### A. load packages ####
library(devtools)
library(TypeSeqHPV)
library(optigrab)
library(drake)
library(tidyverse)
library(igraph)
library(jsonlite)
library(parallel)
library(rmarkdown)
library(furrr)
library(future)

source("/data/R/methyl_startplugin_parse.R")
source("/data/R/adam_demux.R")


#### B. get command line arguments ####
args_bam_files_dir = optigrab::opt_get('bam_files_dir')
args_barcode_list = optigrab::opt_get('barcode_list')
args_run_manifest = optigrab::opt_get('run_manifest')
args_is_torrent_server = optigrab::opt_get('is_torrent_server')
args_start_plugin = optigrab::opt_get('start_plugin')

#### 1. parse plugin data ####
pkgconfig::set_config("drake::strings_in_dots" = "literals")
ion_plan <- drake::drake_plan(

    parse = (if ( args_is_torrent_server == "yes")
    {methyl_startplugin_parse(args_start_plugin)}
    else{"not torrent server"}),

#### 2. demux bams ####
demux_bams_6 = adam_demux(args_bam_files_dir) %>%
    glimpse()

)

#### C. execute workflow plan ####
if ( args_is_torrent_server == "yes") { setwd("/mnt")}

future::plan(multiprocess)
drake::make(ion_plan)

#### D. make html block for torrent server ####
html_block = if ( args_is_torrent_server == "yes") {
    render("/TypeSeqHPV/inst/reports/torrent_server_html_block.R",
           output_dir = "/mnt")}else{"not torrent server"}


