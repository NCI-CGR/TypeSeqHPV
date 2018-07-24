#' ---
#' title: TypeSeq HPV QC Report
#' author: " "
#' date: "`r format(Sys.time(), '%d %B, %Y')`"
#' output:
#'  html_document
#' ---


#+ load packages, echo=FALSE, include = FALSE
library(tidyverse)
library(stringr)
library(jsonlite)
library(scales)
sessionInfo()


#+ get args, echo=FALSE, include = FALSE
read_lines("args.R") %>% 
writeLines()
source("args.R")


#+ determine run type, echo=FALSE
plugin_json = fromJSON(args_start_plugin_path, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

run_type = plugin_json$runplugin$run_type

#' # {.tabset}
#' ## Analysis Output

#+ full run, echo=FALSE, results='asis', eval=run_type!="thumbnail"

cat('

<a href="./TypeSeqHPV_QC_report.pdf" target="_blank">QC Report</a>
  
[TypeSeq HPV Report Files](./TypeSeqHPV_Report_Files.zip)  
  

  
')

#+ thumbnail run, echo=FALSE, results='asis', eval=run_type=="thumbnail"
cat('

Thumbnail data insufficient for typing analysis.  
    
Please see full report.

')
