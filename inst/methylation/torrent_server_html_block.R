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
plugin_json = fromJSON("./startplugin.json", simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

run_type = plugin_json$runplugin$run_type

#' # {.tabset}
#' ## Analysis Output

#+ full run, echo=FALSE, results='asis', eval=run_type!="thumbnail"

cat('

[Hotpsot variant data - all samples](./hotspot_variants_table.csv)



')

#+ thumbnail run, echo=FALSE, results='asis', eval=run_type=="thumbnail"
cat('

Thumbnail data insufficient for methylation analysis.

Please see full report.

')
