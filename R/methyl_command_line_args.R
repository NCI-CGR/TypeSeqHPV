#'
methyl_command_line_args <- function(){
    require(jsonlite)
    require(tidyverse)
    library(optigrab)

    args_df = data_frame(
            manifest = optigrab::opt_get('manifest'),
            control_definitions = optigrab::opt_get('control_definitions'),
            barcode_file = optigrab::opt_get('barcode_file'),
            tvc_parameters = optigrab::opt_get('tvc_parameters'),
            reference = optigrab::opt_get('reference'),
            region_bed = optigrab::opt_get('region_bed'),
            hotspot_vcf = optigrab::opt_get('hotspot_vcf'),
            is_torrent_server = optigrab::opt_get('is_torrent_server'),
            start_plugin = optigrab::opt_get('start_plugin')) %>%
        gather()

if ( args_df$is_torrent_server == "yes") {

    setwd("/mnt")


    plugin_json = fromJSON(args_start_plugin, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

    # config file
    data_frame(values = plugin_json$pluginconfig$config_file) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = c("key", "value")) %>%
        write_csv("config_file.csv")
}

config_file = read_csv("config_file.csv", col_names = c("key", "value")) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    mutate(value = paste("/user_files/", config_file)) %>%
    glimpse()

new_args_df = args_df %>%
    anti_join(config_file, by = "key") %>%
    bind_rows(config_file) %>%
    spread("key", "value")

return(new_args_df)

    }




