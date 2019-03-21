#' ---
#' title: TypeSeq HPV Methylation Plugin
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

[variant table](./variant_table.csv)

[read summary](./read_summary.csv)

[coverage matrix](./coverage_matrix_results.csv)

[frequency matrix](./freq_matrix_results.csv)

[lineage variants](./lineage_variants_results.csv)

[control results](./control_results.csv)

[archive of outputs](./TypeSeqHPVMethyl_outputs.zip)



')

#+ thumbnail run, echo=FALSE, results='asis', eval=run_type=="thumbnail"
cat('

Thumbnail data insufficient for methylation analysis.

Please see full report.

')
