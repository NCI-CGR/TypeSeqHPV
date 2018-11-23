#### A. load packages ####
library(devtools)
library(TypeSeqHPV)
library(optigrab)
library(drake)
library(tidyverse)
library(igraph)
library(jsonlite)
library(parallel)
library(rmarkdown)
library(furrr)
library(future)
library(magrittr)

#### B. get command line arguments ####
args_bam_files_dir = optigrab::opt_get('bam_files_dir')
args_lineage_reference = optigrab::opt_get('lineage_reference')
args_bam_header = optigrab::opt_get('bam_header')
args_barcode_list = optigrab::opt_get('barcode_list')
args_control_defs = optigrab::opt_get('control_defs')
args_run_manifest = optigrab::opt_get('run_manifest')
args_pos_neg_filtering_criteria =
    optigrab::opt_get('pos_neg_filtering_criteria')
args_scaling_table = optigrab::opt_get('scaling_table')
args_parameter_file = optigrab::opt_get('parameter_file')
args_is_torrent_server = optigrab::opt_get('is_torrent_server')
args_start_plugin = optigrab::opt_get('start_plugin')
args_custom_groups = optigrab::opt_get('custom_groups')
args_custom_report_script_dir = optigrab::opt_get('custom_report_script_dir')

#### 1. parse plugin data ####
pkgconfig::set_config("drake::strings_in_dots" = "literals")
ion_plan <- drake::drake_plan(

parse = (if ( args_is_torrent_server == "yes")
            {startplugin_parse(args_start_plugin)}
            else{"not torrent server"}),


#### 2. create bam_json from bam files ####
bam_json = (data_frame(path = dir(args_bam_files_dir, pattern = ".bam",
                                 full.names = FALSE)) %>%
    filter(!(str_detect(path, "json"))) %>%
    split(.$path) %>%
    future_map_dfr(convert_bam_to_json, args_bam_files_dir)),


#### 3. ion read processing ####
ion_read_processing_df = bam_json %>%
    mutate(path = paste0(path, ".json")) %>%
    glimpse() %>%
    split(.$path) %>%
    future_map_dfr(ion_read_processor,
              args_lineage_reference_path = args_lineage_reference,
              args_barcode_list = args_barcode_list,
              parameters_df = parameters_df) %>%
    do({system("cat *read_metrics.json > read_metrics_merged.json")
        system("cat *hpv_lineage.json > hpv_lineage_merged.json")
        system("cat *bc2_demultiplex.json > bc2_demultiplex_merged.json")
        temp = as_tibble(.)}),

#### 4. create parameters dataframe ####
parameters_df = read_in_parameters_csv(args_parameter_file),

#### 5. get bam header ####
bam_header_df = extract_header(args_bam_files_dir,
                               data_frame(path =
                                    dir(args_bam_files_dir,
                                        pattern = ".bam",
                                        full.names = FALSE))) %>%
                glimpse() %>%
                read_in_bam_header(),

#### 6. create hpv_types dataframe ####
hpv_types_df = TypeSeqHPV::create_hpv_types_table(
    ion_read_processing_df,
    args_run_manifest,
    bam_header_df,
    parameters_df),

#### 7. create read metrics dataframe ####
read_metrics_df = create_full_run_read_metrics_df(
    ion_read_processing_df,
    hpv_type_counts = hpv_types_df),

#### 8. create scaling list ####
scaling_list = scaling_of_b2m_human_control(
    read_metrics_df,
    args_run_manifest,
    args_scaling_table,
    args_pos_neg_filtering_criteria) %>%
    glimpse(),

#### 9. create initial pn matrix ####
initial_pn_matrix = create_inital_pos_neg_matrix(
    hpv_types_df,
    scaling_list$factoring_table,
    scaling_list$filtering_criteria),

#### 10. create control results ####
control_results = calculate_expected_control_results(
    args_control_defs,
    initial_pn_matrix),

#### 11. create final pn matrix ####
final_pn_matrix = finalize_pn_matrix(
    initial_pn_matrix,
    scaling_list$filtering_criteria,
    control_results$control_results_final),

#### 12. split devlierables ####
split_deliverables = split_pn_matrix_into_multiple_deliverables(
    final_pn_matrix,
    control_results$control_results_final),

#### 13. create grouped samples only matrix ####
grouped_samples_only_matrix = prepare_grouped_samples_only_matrix_outputs(
    args_custom_groups,
    split_deliverables$samples_only_matrix,
    parameters_df),

#### 14. create lineage dataframe ####
lineage_df = prepare_lineage_df_safe(
    args_lineage_reference,
    ion_read_processing,
    split_deliverables$samples_only_matrix),


#### 15. export csv files ####
collection_of_csv_files = write_all_csv_files(
    final_grouped_samples_only_matrix = grouped_samples_only_matrix,
    read_metrics = read_metrics_df,
    final_pn_matrix = final_pn_matrix,
    hpv_types = hpv_types_df,
    control_matrix = split_deliverables$control_matrix,
    failed_samples_matrix = split_deliverables$failed_samples_matrix,
    full_lineage_table_with_manifest = lineage_df,
    parameters_df = parameters_df),

#### 16. generate qc report ####
ion_qc_report = render_ion_qc_report(
    args_start_plugin = args_start_plugin,
    split_deliverables = split_deliverables,
    samples_and_controls_df_out = samples_and_controls_df_out,
    control_results = control_results,
    hpv_types_df = hpv_types_df,
    final_pn_matrix = final_pn_matrix,
    scaling_list = scaling_list,
    lineage_df = lineage_df,
    bam_header_df = bam_header_df),

#### 17. make html block for torrent server ####
html_block_and_client_outputs = grouped_samples_only_matrix %>%
    glimpse() %>%
    ungroup() %T>%
    do({

    temp = parse$config_file %>%
    filter(key == "client") %>%
    mutate(report_script = case_when(
        value == "Default" ~
            "/TypeSeqHPV/inst/reports/torrent_server_html_block.R",
        TRUE ~
            paste0(args_custom_report_script_dir,"/",
                   .$value, "_client_report.R"))) %>%
    glimpse() %T>%
    map_df(render(.$report_script,
                  output_dir = "/mnt",
                  knit_root_dir = "/mnt",
                  intermediates_dir = "/mnt",

                  output_file = "torrent_server_html_block.html"))

    })

)

#### C. execute workflow plan ####
setwd("/mnt")

prepare_lineage_df_safe <- possibly(TypeSeqHPV::prepare_lineage_df,
                                    otherwise = data.frame())

future::plan(multiprocess)

drake::make(ion_plan)





