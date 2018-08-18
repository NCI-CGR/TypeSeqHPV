#' ---
#' title: Ion Torrent TypeSeq HPV Report
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

get_run_metadata_safe <- possibly(TypeSeqHPV::get_run_metadata, otherwise=data.frame())

startPluginDf = get_run_metadata_safe(args_start_plugin)

#' \newpage
#' ## SAMPLE Results Summary

#+ SAMPLE Results Summary, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE
sample_summary_safe <- possibly(TypeSeqHPV::sample_summary, otherwise=data.frame())

temp = sample_summary_safe(split_deliverables$samples_only_matrix)

#' ## CONTROL Results Summary

#+ CONTROL Results Summary, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE
control_summary_safe <- possibly(TypeSeqHPV::control_summary, otherwise=data.frame())

temp = control_summary_safe(control_results$control_results_final)

#' \newpage
#' ## Counts and Percentage of Types Positive by Project

#+ Counts and Percent Types Positive by Project, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"
percent_positive_histogram_safe <- possibly(TypeSeqHPV::percent_positive_histogram, otherwise=data.frame())

temp = percent_positive_histogram(split_deliverables$samples_only_matrix, bam_header_df) 

#' \newpage
#' ## Coinfection Rate Histogram
#+ coinfection rate histogram, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"

coinfection_rate_histogram_safe <- possibly(TypeSeqHPV::coinfection_rate_histogram, otherwise=data.frame())

temp = coinfection_rate_histogram_safe(split_deliverables$samples_only_matrix)

#' \newpage
#' ## Signal-to-Noise Plot
#+ signal to noise plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=20, fig.height=9, fig.align = "center"

signal_to_noise_plot_safe <- possibly(TypeSeqHPV::signal_to_noise_plot, otherwise=data.frame())

temp = signal_to_noise_plot(hpv_types_df %>% gather(HPV_Type, HPV_Type_count, starts_with("HPV")), 
                            final_pn_matrix, 
                            scaling_list)
#' \newpage
#' ## Distribution of Sample HPV Positivity by Project

#+ HPV Status Circle Plot, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"

hpv_status_circle_plot_safe <- possibly(TypeSeqHPV::hpv_status_circle_plot, otherwise=data.frame())

temp = hpv_status_circle_plot_safe(split_deliverables$samples_only_matrix)


#' \newpage
#' ## HPV Positivity by Assay Plate Code

#+  hpv positivity table, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE
samples_and_controls_df = hpv_positivity_table(split_deilverables)


#' \newpage
#' ## Lineage Plots

#+ lineage table plot 1, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"

lineage_plot_safe <- possibly(TypeSeqHPV::lineage_plot, otherwise=data.frame())

temp = lineage_plot_safe(lineage_df, 1)

#' \newpage
#+ normalized lineage table plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"
temp = lineage_plot_safe(lineage_df, 2)
