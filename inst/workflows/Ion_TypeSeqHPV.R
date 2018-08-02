suppressMessages(library(optigrab))
suppressMessages(library(tidyverse))

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
