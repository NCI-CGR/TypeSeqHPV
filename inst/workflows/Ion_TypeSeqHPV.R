require(TypeSeqHPV)
#TypeSeqHPV::ion_report_load_packages()
detach("package:drake", unload=TRUE)
detach("package:tidyr", unload=TRUE)
detach("package:dplyr", unload=TRUE)
library(drake)
library(tidyr)


args_df = data_frame(
lineage_reference = opt_get('lineage_reference'),
barcode_list =opt_get('barcode_list'),
control_defs =opt_get('control_defs'),
run_manifest =opt_get('run_manifest'),
pos_neg_filtering_criteria =opt_get('pos_neg_filtering_criteria'),
scaling_table =opt_get('scaling_table'),
parameter_file_path =opt_get('parameter_file_path'),
is_torrent_server =opt_get('is_torrent_server'),
start_plugin_path =opt_get('start_plugin_path'),
custom_groups_path =opt_get('custom_groups_path'))

args_df %>%
glimpse()


#pkgconfig::set_config("drake::strings_in_dots" = "literals")

ion_plan <- drake_plan(
################################# bam input #################################
bam_file_input = data_frame(path = dir(args_df$bam_files_dir, pattern=".bam")),

################################# bam_json #################################
bam_json = create_bam_json(bam_file_input, args_df$bam_files_dir), 
  
################################# ion_read_processing #################################
ion_read_processing_df = ion_read_processor_apply(bam_json, args_df, parameters_df), 

################################# parameters file input #################################
parameters_csv_input = args_df$parameter_file,  
  
################################# parameters dataframe #################################
parameters_df = TypeSeqHPV::read_in_parameters_csv(parameters_csv_input),

################################# bam header df  #################################
bam_header_df = TypeSeqHPV::read_in_bam_header(file_in(args_df$bam_header)),

################################# hpv types dataframe #################################
hpv_types_df = TypeSeqHPV::create_hpv_types_table(ion_read_processing_df, args_df$run_manifest, bam_header_df, parameters_df),

################################# read metrics df #################################
read_metrics_df = TypeSeqHPV::create_full_run_read_metrics_df(ion_read_processing_df, 
                                                  hpv_type_counts=hpv_types_df),

################################# scaling of b2m control #################################
scaling_list = TypeSeqHPV::scaling_of_b2m_human_control(read_metrics_df, 
                                                  args_df$run_manifest, 
                                                  args_df$scaling_table, 
                                                  args_df$pos_neg_filtering_criteria),

#################################initial pn matrix #################################
initial_pn_matrix = TypeSeqHPV::create_inital_pos_neg_matrix(hpv_types_df, 
                                                               scaling_list$factoring_table, scaling_list$filtering_criteria),


################################# expected control results #################################
control_results = TypeSeqHPV::calculate_expected_control_results(args_df$control_defs, initial_pn_matrix),
 

################################# finalize pn matrix #################################
final_pn_matrix = TypeSeqHPV::finalize_pn_matrix(initial_pn_matrix, 
                                                   scaling_list$filtering_criteria, 
                                                   control_results$control_results_final),

################################# split pn matrix outputs #################################
split_deliverables = TypeSeqHPV::split_pn_matrix_into_multiple_deliverables(final_pn_matrix, 
                                                                              control_results$control_results_final),

################################# prep grouped samples #################################
grouped_samples_only_matrix = TypeSeqHPV::prepare_grouped_samples_only_matrix_outputs(args_df$custom_groups, 
                                                                                        split_deliverables$samples_only_matrix,
                                                                                     parameters_df),
################################# lineage df #################################
lineage_df = TypeSeqHPV::prepare_lineage_df(args_df$lineage_reference, 
                                              ion_read_processing, split_deliverables$samples_only_matrix),

################################# create csv files #################################
collection_of_csv_files = TypeSeqHPV::write_all_csv_files(final_grouped_samples_only_matrix=grouped_samples_only_matrix, 
                     read_metrics=read_metrics_df,
                     final_pn_matrix = final_pn_matrix, 
                     hpv_types = hpv_types_df, 
                     control_matrix = split_deliverables$control_matrix, 
                     failed_samples_matrix=split_deliverables$failed_samples_matrix, 
                     full_lineage_table_with_manifest=lineage_df,
                     parameters_df = parameters_df),

################################# ion qc knitr report #################################
ion_qc_report = render_ion_qc_report(args_start_plugin_path=args_df$start_plugin, 
                              split_deliverables=split_deliverables, 
                              samples_and_controls_df_out=samples_and_controls_df_out, 
                              control_results=control_results, 
                              hpv_types_df=hpv_types_df,
                              final_pn_matrix=final_pn_matrix,
                              scailing_list = scailing_list,
                             lineage_df=lineage_df) %>% ({file_out('Ion_Torrent_report.pdf')})
  )


make(ion_plan)

