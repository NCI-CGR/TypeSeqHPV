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

new_samples_only_matrix = grouped_samples_only_matrix_temp %>%
    select(Project, Sample_Owner, Assay_Batch_Code, Owner_Sample_ID,
           Barcode = barcode, Human_control = Human_Control,
           Num_Types_Pos = not_masked_and_not_grouped_Num_Types_Pos,
           starts_with("HPV")) %>%
    glimpse() %>%
    group_by(Project) %>%
    do({
        temp = as_tibble(.) %>%
            mutate(filename = paste(
                                    .$Assay_Batch_Code[1],
                                    "samples_only_matrix.csv", sep = "_"))

        output = temp %>%
            select(-filename)

        output = output[, colSums(is.na(output)) == 0]

        write_csv(output, temp$filename[1])

        temp = temp
    })

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
