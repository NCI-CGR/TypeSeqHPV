#'
methyl_startplugin_parse <- function(args_df){
    require(jsonlite)
    require(tidyverse)

if ( args_is_torrent_server == "yes") {

    plugin_json = fromJSON(args_start_plugin, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

    #manifest
    data_frame(values = plugin_json$pluginconfig$typing_manifest) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        write_csv("manifest.csv")

    #control_defs
    data_frame(values = plugin_json$pluginconfig$control_definitions) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        write_csv("control_defs.csv")

    #barcode_file
    data_frame(values = plugin_json$pluginconfig$barcode_file) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        write_csv("barcodes.csv")

    # config file
    data_frame(values = plugin_json$pluginconfig$config_file) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = c("key", "value")) %>%
        write_csv("config_file.csv")
}

manifest = read_csv(args_df$manifest) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    write_csv("manifest.csv")


control_defs = read_csv(args_df$control_defs) %>%
    map_if(is.factor, as.character) %>%
    as_tibble()

barcode_file = read_csv(args_df$barcode_file) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    write_csv("barcodes.csv")

parameter_file = read_csv(args_df$parameter_file) %>%
    map_if(is.factor, as.character) %>%
    as_tibble()

#return list output

return(list(manifest = manifest,
            report_grouping = report_grouping,
            control_defs = control_defs,
            config_file = config_file,
            barcode_file = barcode_file,
            parameter_file = parameter_file
            ))



}


