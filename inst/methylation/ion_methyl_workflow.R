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

source("/package/R/methyl_startplugin_parse.R")
source("/package/R/adam_demux.R")
source("/package/R/tvc_run.R")
source("/package/R/samtools_sort.R")

setwd("/mnt")

#clean(run_tvc)

#### B. get command line arguments ####
args_is_torrent_server = optigrab::opt_get('is_torrent_server')

#### C. create workflow plan ####
pkgconfig::set_config("drake::strings_in_dots" = "literals")
ion_plan <- drake::drake_plan(

#### 1. parse plugin data ####
parse_plugin = if (args_is_torrent_server == "yes") {
    methyl_startplugin_parse(args_start_plugin)
    },

#### 2. demux bams ####
demux_bams = adam_demux(args_bam_files_dir) %>%
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
    glimpse()

)

#### D. execute workflow plan ####
if ( args_is_torrent_server == "yes") { setwd("/mnt")}

system("mkdir sorted_bams")
system("mkdir vcf")


future::plan(multiprocess)
drake::make(ion_plan)

#### E. make html block for torrent server ####
html_block = if ( args_is_torrent_server == "yes") {
    render("/TypeSeqHPV/inst/reports/torrent_server_html_block.R",
           output_dir = "/mnt")}else{"not torrent server"}


