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

startPluginDf

#' \newpage
#' ## SAMPLE Results Summary

#+ SAMPLE Results Summary, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE

sample_summary_out

#' ## CONTROL Results Summary

#+ CONTROL Results Summary, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE

control_summary_out

#' \newpage
#' ## Counts and Percentage of Types Positive by Project

#+ Counts and Percent Types Positive by Project, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"

percent_positive_histogram_out

#' \newpage
#' ## Coinfection Rate Histogram
#+ coinfection rate histogram, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"

coinfection_rate_histogram_out

#' \newpage
#' ## Signal-to-Noise Plot
#+ signal to noise plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=20, fig.height=9, fig.align = "center"

signal_to_noise_plot_safe <- possibly(TypeSeqHPV::signal_to_noise_plot, otherwise=data.frame())

temp = signal_to_noise_plot_safe(hpv_types_df %>% gather(HPV_Type, HPV_Type_count, starts_with("HPV")), 
                            final_pn_matrix, 
                            scaling_list$filtering_criteria)
#' \newpage
#' ## Distribution of Sample HPV Positivity by Project

#+ HPV Status Circle Plot, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"

signal_to_noise_plot_out

#' \newpage
#' ## HPV Positivity by Assay Plate Code

#+  hpv positivity table, echo=FALSE, message=FALSE, warning=FALSE, fig.align = "center", results='asis', eval=TRUE

samples_and_controls_df_out

#' \newpage
#' ## Lineage Plots

#+ lineage table plot 1, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"

lineage_plot1_out

#' \newpage
#+ normalized lineage table plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"

lineage_plot2_out

