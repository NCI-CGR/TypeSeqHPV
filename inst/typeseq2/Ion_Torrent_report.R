#' ---
#' title: Ion Torrent TypeSeq2 HPV Report
#' author: " "
#' date: "`r format(Sys.time(), '%d %B, %Y')`"
#' output:
#'  pdf_document:
#'     toc: true
#'     toc_depth: 3
#' classoption: landscape
#' ---

#' ## Run Metadata

#+  get run metadata, results='asis', echo=FALSE
# startplugin.json

get_run_metadata_safe <- possibly(get_run_metadata, otherwise = data.frame())

startPluginDf = get_run_metadata_safe(args_df$start_plugin)

#' \newpage
#' ## SAMPLE Results Summary

#+ SAMPLE Results Summary, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE
sample_summary_safe <- possibly(sample_summary, otherwise =  data.frame())
#samples_only_matrix_results.csv

temp = sample_summary_safe(samples_only_pn_matrix)

#' ## PLATE Results Summary

#+ PLATE Results Summary, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE
plate_summary_safe <- possibly(plate_summary, otherwise = data.frame())
#needs controls only and samples only matrix
temp = plate_summary_safe(split_deliverables)

#' \newpage
#' ## Counts and Percentage of Types Positive by Project

#+ Counts and Percent Types Positive by Project, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"
#samples_only matrix
percent_positive_histogram_safe <- possibly(TypeSeqHPV::percent_positive_histogram, otherwise = data.frame())

temp = percent_positive_histogram_safe(samples_only_matrix, bam_header_df)

#' \newpage
#' ## Coinfection Rate Histogram
#+ coinfection rate histogram, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"
#samples only matrix
coinfection_rate_histogram_safe <- possibly(coinfection_rate_histogram,
                                            otherwise = data.frame())

temp = coinfection_rate_histogram_safe(samples_only_matrix)

#' \newpage
#' ## Signal-to-Noise Plot
#+ signal to noise plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=20, fig.height=9, fig.align = "center"
#scaling file and simple pn matrix and read counts matrix
signal_to_noise_plot_safe <- possibly(TypeSeqHPV::signal_to_noise_plot, otherwise = data.frame())

temp = signal_to_noise_plot_safe(read_counts_matrix_wide %>% gather(HPV_Type, HPV_Type_count, starts_with("HPV")),
                            detailed_pn_matrix,
                            scaling_list)
#' \newpage
#' ## Distribution of Sample HPV Positivity by Project

#+ HPV Status Circle Plot, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"
# samples only matrix
hpv_status_circle_plot_safe <- possibly(TypeSeqHPV::hpv_status_circle_plot, otherwise = data.frame())

temp = hpv_status_circle_plot_safe(samples_only_matrix)

#' \newpage
#' ## Lineage Plots

#+ lineage table plot 1, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"

lineage_plot_safe <- possibly(TypeSeqHPV::lineage_plot, otherwise = data.frame())
# lineage results .csv
temp = lineage_plot_safe(lineage_df, 1)

#' \newpage
#+ normalized lineage table plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"
temp = lineage_plot_safe(lineage_df, 2)
