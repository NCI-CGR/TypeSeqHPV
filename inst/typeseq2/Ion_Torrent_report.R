#' ---
#' title: Ion Torrent TypeSeq2 HPV Report
#' author: " "
#' date: "`r format(Sys.time(), '%d %B, %Y')`"
#' output:
#'  pdf_document:
#'     toc: true
#'     toc_depth: 3
#' classoption: landscape
#' html_document:
#'    toc: true
#'    theme: united
#' ---

#' ## Run Metadata

#+  get run metadata, results='asis', echo=FALSE
# startplugin.json

get_run_metadata_safe <- possibly(get_run_metadata, otherwise = data.frame())

startPluginDf = get_run_metadata_safe(args_df)

#' \newpage
#' ## SAMPLE Results Summary

#+ SAMPLE Results Summary, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE
sample_summary_safe <- possibly(sample_summary, otherwise =  data.frame())
#samples_only_matrix_results.csv

temp = sample_summary_safe(samples_only_for_report)

#' \newpage
#' ## PLATE Results Summary

#+ PLATE Results Summary, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE
plate_summary_safe <- possibly(plate_summary, otherwise = data.frame())
#needs controls only and samples only matrix
temp = plate_summary(control_for_report,samples_only_for_report)


#' \newpage
#' ## Control Summary

#+ Control summary, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"

Internal_control_summary_safe <- possibly(Internal_control_summary,otherwise = data.frame())
temp = Internal_control_summary_safe(detailed_pn_matrix_for_report,manifest,control_for_report,specimen_control_defs)



#' \newpage
#' ## Counts and Percentage of Types Positive by Project

#+ Counts and Percent Types Positive by Project, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"
#samples_only matrix
percent_positive_histogram_safe <- possibly(TypeSeqHPV::percent_positive_histogram, otherwise = data.frame())

temp = percent_positive_histogram(samples_only_for_report)

#' \newpage
#' ## Coinfection Rate Histogram
#+ coinfection rate histogram, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"
#samples only matrix
coinfection_rate_histogram_safe <- possibly(coinfection_rate_histogram,
                                            otherwise = data.frame())

temp = coinfection_rate_histogram(samples_only_for_report)

#' \newpage
#' ## Signal-to-Noise Plot
#+ signal to noise plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=20, fig.height=9, fig.align = "center"
#scaling file and simple pn matrix and read counts matrix
signal_to_noise_plot_safe <- possibly(TypeSeqHPV::signal_to_noise_plot, otherwise = data.frame())
temp = signal_to_noise_plot(read_count_matrix_report,detailed_pn_matrix_for_report,pn_filters)

#' \newpage
#' ## Distribution of Sample HPV Positivity by Project

#+ HPV Status Circle Plot, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"
# samples only matrix
hpv_status_circle_plot_safe <- possibly(TypeSeqHPV::hpv_status_circle_plot, otherwise = data.frame())

temp = hpv_status_circle_plot(samples_only_for_report)

#' \newpage
#' ## Lineage Plots

#+ lineage table plot 1, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"

lineage_plot_safe <- possibly(TypeSeqHPV::lineage_plot, otherwise = data.frame())
# lineage results .csv
temp = lineage_plot(lineage_for_report, 1)


#' \newpage
#+ normalized lineage table plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"
temp = lineage_plot(lineage_for_report, 2)





#' \newpage
#' ## Plate map
#+ Plate map, echo=FALSE, message=FALSE, warning=FALSE, fig.width=12, fig.height=9, fig.align = "center"

plate_map_safe <- possibly(plate_map,otherwise = data.frame())
temp = plate_map(manifest,detailed_pn_matrix_for_report,specimen_control_defs,control_for_report)






