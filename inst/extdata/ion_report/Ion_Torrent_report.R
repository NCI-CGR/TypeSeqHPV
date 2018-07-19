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


#+ A1 setup environment, include=FALSE, eval=TRUE, echo=FALSE
TypeSeqHPV::ion_report_load_packages()
TypeSeqHPV::ion_report_get_args(is_test=!exists("is_ts"))
parameters_df = TypeSeqHPV::read_in_parameters_csv(args_parameter_file_path)

#+ A2 summarize hpv type count json, include=FALSE, eval=TRUE, echo=FALSE
bam_header = TypeSeqHPV::read_in_bam_header(args_bam_header_path)

hpv_types_df = TypeSeqHPV::create_hpv_types_table(args_hpv_types_path, args_run_manifest_path, bam_header, parameters_df)

#+ A3 Summarize Read Metrics json, include=FALSE, eval=TRUE, echo=FALSE

read_metrics_df = TypeSeqHPV::create_full_run_read_metrics_df(args_read_metrics_path, 
                                                  hpv_type_counts=hpv_types_df)

scaling_list = TypeSeqHPV::scaling_of_b2m_human_control(read_metrics_df, 
                                                  args_run_manifest_path, 
                                                  args_scaling_table, 
                                                  args_pos_neg_filtering_criteria_path)

#+ A4 - Create Positive / Negative Matrix, include=FALSE, eval=TRUE, echo=FALSE
initial_pn_matrix = TypeSeqHPV::create_inital_pos_neg_matrix(hpv_types_df, scaling_list$factoring_table, scaling_list$filtering_criteria)

control_results = TypeSeqHPV::calculate_expected_control_results(args_control_defs, initial_pn_matrix)

final_pn_matrix = TypeSeqHPV::finalize_pn_matrix(initial_pn_matrix, scaling_list$filtering_criteria, control_results$control_results_final)

split_deliverables = TypeSeqHPV::split_pn_matrix_into_multiple_deliverables(final_pn_matrix, control_results$control_results_final) 

grouped_samples_only_matrix = TypeSeqHPV::prepare_grouped_samples_only_matrix_outputs(args_custom_groups_path, split_deliverables$samples_only_matrix)


#+ A5 - Prepare Lineage Table Dataframe, include=FALSE, eval=TRUE, echo=FALSE
lineage_df = TypeSeqHPV::prepare_lineage_df(args_lineage_reference_path, args_lineage_table_path, split_deliverables$samples_only_matrix)


#+ A6 - write all csv files, include=FALSE, eval=TRUE, echo=FALSE
TypeSeqHPV::write_all_csv_files(final_grouped_samples_only_matrix=grouped_samples_only_matrix, 
                     read_metrics=read_metrics_df,
                     final_pn_matrix = final_pn_matrix, 
                     hpv_types = hpv_types_df, 
                     control_matrix = split_deliverables$control_matrix, 
                     failed_samples_matrix=split_deliverables$failed_samples_matrix, 
                     full_lineage_table_with_manifest=lineage_df,
                     parameters_df = parameters_df)

#+  display lineage_df, include=FALSE, eval=FALSE, echo=FALSE
lineage_df %>% display()




#' ## Run Metadata

#+  get run metadata, results='asis', echo=FALSE

get_run_metadata_safe <- possibly(TypeSeqHPV::get_run_metadata, otherwise=data.frame())

startPluginDf = get_run_metadata_safe(args_start_plugin_path)

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
percent_positive_histogram_safe <- possibly(TypeSeqHPV::percent_positve_histogram, otherwise=data.frame())

temp = percent_positive_histogram_safe(split_deliverables$samples_only_matrix) 

#' \newpage
#' ## Coinfection Rate Histogram
#+ coinfection rate histogram, echo=FALSE, message=FALSE, warning=FALSE, out.width = '200%', fig.align = "center"

coinfection_rate_histogram_safe <- possibly(TypeSeqHPV::coinfection_rate_histogram, otherwise=data.frame())

temp = coinfection_rate_histogram_safe(split_deliverables$samples_only_matrix)

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

hpv_status_circle_plot_safe <- possibly(TypeSeqHPV::hpv_status_circle_plot, otherwise=data.frame())

temp = hpv_status_circle_plot_safe(split_deliverables$samples_only_matrix)

#' \newpage
#' ## Lineage Plots

#+ lineage table plot 1, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"

lineage_plot_safe <- possibly(TypeSeqHPV::lineage_plot, otherwise=data.frame())

temp = lineage_plot_safe(lineage_df, 1)

#' \newpage
#+ normalized lineage table plot, echo=FALSE, message=FALSE, warning=FALSE, fig.width=16, fig.height=9, fig.align = "center"
temp = lineage_plot_safe(lineage_df, 2)


