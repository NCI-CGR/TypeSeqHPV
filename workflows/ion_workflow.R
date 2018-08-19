#### A. load packages ####
require(devtools)
install_github("cgrlab/TypeSeqHPV", force=TRUE)
require(TypeSeqHPV)
library(optigrab)
library(drake)
library(tidyverse)
library(igraph)
library(jsonlite)
library(parallel)
library(rmarkdown)
library(furrr)
library(future)

#### B. get command line arguments ####
args_bam_files_dir = opt_get('bam_files_dir')
args_lineage_reference = opt_get('lineage_reference')
args_bam_header = opt_get('bam_header')
args_barcode_list =opt_get('barcode_list')
args_control_defs =opt_get('control_defs')
args_run_manifest =opt_get('run_manifest')
args_pos_neg_filtering_criteria =opt_get('pos_neg_filtering_criteria')
args_scaling_table =opt_get('scaling_table')
args_parameter_file =opt_get('parameter_file')
args_is_torrent_server =opt_get('is_torrent_server')
args_start_plugin =opt_get('start_plugin')
args_custom_groups =opt_get('custom_groups')

#### 1. parse plugin data #### 
pkgconfig::set_config("drake::strings_in_dots" = "literals")
ion_plan <- drake_plan(
  
parse = if(args_is_torrent_server=="yes"){startplugin_parse(args_start_plugin)}else{"not torrent server"},
  
#### 2. bam_json ####
bam_json = data_frame(path = dir(args_bam_files_dir, pattern=".bam", full.names = FALSE))  %>%
filter(!(str_detect(path, "json"))) %>%
split(.$path) %>%
future_map_dfr(convert_bam_to_json, args_bam_files_dir),

#### 3. ion read processing ####
ion_read_processing_df = bam_json %>% 
mutate(path = paste0(path, ".json")) %>%
glimpse() %>%
split(.$path) %>%
future_map_dfr(ion_read_processor,
              args_lineage_reference_path=args_lineage_reference,
              args_barcode_list=args_barcode_list,
              parameters_df=parameters_df) %>%
do({
system("cat *read_metrics.json > read_metrics_merged.json")
system("cat *hpv_lineage.json > hpv_lineage_merged.json")
system("cat *bc2_demultiplex.json > bc2_demultiplex_merged.json") 
temp = as_tibble(.)}),

#### 4. parameters dataframe ####
parameters_df = read_in_parameters_csv(args_parameter_file),

#### 5. bam header ####
bam_header_df = extract_header(args_bam_files_dir, data_frame(path = dir(args_bam_files_dir, pattern=".bam", full.names = FALSE))) %>%
                glimpse() %>%
                read_in_bam_header(),

#### 6. hpv_types dataframe ####
hpv_types_df = TypeSeqHPV::create_hpv_types_table(ion_read_processing_df, args_run_manifest, bam_header_df, parameters_df),

#### 7. read metrics dataframe ####
read_metrics_df = create_full_run_read_metrics_df(ion_read_processing_df, hpv_type_counts=hpv_types_df),

#### 8. scaling list ####
scaling_list = scaling_of_b2m_human_control(read_metrics_df,
                                            args_run_manifest,
                                            args_scaling_table,
                                            args_pos_neg_filtering_criteria) %>% 
glimpse(),

#### 9. initial pn matrix ####
initial_pn_matrix = create_inital_pos_neg_matrix(hpv_types_df, 
                                                 scaling_list$factoring_table, 
                                                 scaling_list$filtering_criteria),



#### 10. control results ####
control_results = calculate_expected_control_results(args_control_defs, initial_pn_matrix),


#### 11. final pn matrix ####
final_pn_matrix = finalize_pn_matrix(initial_pn_matrix, 
                                                 scaling_list$filtering_criteria, 
                                                 control_results$control_results_final),


#### 12. split devlierables ####
split_deliverables = split_pn_matrix_into_multiple_deliverables(final_pn_matrix,
                                                                control_results$control_results_final),


#### 13. grouped samples only matrix ####
grouped_samples_only_matrix = prepare_grouped_samples_only_matrix_outputs(args_custom_groups,
                                                                          split_deliverables$samples_only_matrix,
                                                                          parameters_df),

#### 14. lineage dataframe ####
lineage_df = prepare_lineage_df(args_lineage_reference, ion_read_processing, split_deliverables$samples_only_matrix),


#### 15. export csv files ####
collection_of_csv_files = write_all_csv_files(final_grouped_samples_only_matrix=grouped_samples_only_matrix, 
                                              read_metrics=read_metrics_df,
                                              final_pn_matrix = final_pn_matrix, 
                                              hpv_types = hpv_types_df, 
                                              control_matrix = split_deliverables$control_matrix, 
                                              failed_samples_matrix=split_deliverables$failed_samples_matrix, 
                                              full_lineage_table_with_manifest=lineage_df,
                                              parameters_df = parameters_df),


#### 16. qc report ####
ion_qc_report = render_ion_qc_report(args_start_plugin=args_start_plugin,
                                     split_deliverables=split_deliverables, 
                                     samples_and_controls_df_out=samples_and_controls_df_out, 
                                     control_results=control_results, 
                                     hpv_types_df=hpv_types_df,
                                     final_pn_matrix=final_pn_matrix,
                                     scaling_list = scaling_list,
                                     lineage_df=lineage_df,
                                     bam_header_df = bam_header_df)) 

#### C. execute plan ####
if(args_is_torrent_server=="yes"){setwd("/mnt")}
future::plan(multiprocess)
make(ion_plan)




