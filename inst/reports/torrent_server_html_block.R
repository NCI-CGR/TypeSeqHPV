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

#+ create new sample only matrix, echo=FALSE, include = FALSE

system(paste0("cp TypeSeqHPV_QC_report.pdf ",
              grouped_samples_only_matrix$Assay_Batch_Code[1],
              "_qc_report.pdf"))

system("zip -j TypeSeqHPV_Report_Files.zip *csv *qc_report.pdf")

#+ determine run type, echo=FALSE
plugin_json = fromJSON(args_start_plugin, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

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
