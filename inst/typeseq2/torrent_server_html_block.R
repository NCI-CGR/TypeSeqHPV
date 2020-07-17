#' ---
#' title: TypeSeq2 HPV Plugin
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


#+ determine run type, echo=FALSE
plugin_json = fromJSON(file("/mnt/startplugin.json"), simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

run_type = plugin_json$runplugin$run_type

#' # {.tabset}
#' ## Analysis Output

#+ full run, echo=FALSE, results='asis', eval=run_type!="thumbnail"

cat('

[positive negative matrix](./*pn_matrix_results.csv)

[detailed pn matrix](./*detailed_pn_matrix_results.csv)

[read count matrix](./*read_counts_matrix_results.csv)

[lineage results](./*lineage_results.csv)

[failed samples pn matrix](./*failed_samples_pn_matrix.csv)

<a href="*control_results.csv" target="_blank">control_results.csv</a>  

[archive of outputs](./TypeSeq2_outputs.zip)




')

#+ thumbnail run, echo=FALSE, results='asis', eval=run_type=="thumbnail"
cat('

Thumbnail data insufficient for methylation analysis.

Please see full report.

')
