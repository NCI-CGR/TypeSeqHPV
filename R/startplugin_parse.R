#'
old_startplugin_parse <- function(args_start_plugin,
                              args_custom_groups,
                              args_control_defs,
                              args_run_manifest,
                              args_config_file,
                              args_is_torrent_server
                              ){
    require(jsonlite)
    require(tidyverse)

    if ( args_is_torrent_server == "yes") {

    plugin_json = fromJSON(args_start_plugin, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

    #manifest
    data_frame(values = plugin_json$pluginconfig$typing_manifest) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        write_csv("typing_manifest.csv")

    #report_grouping
    data_frame(values = plugin_json$pluginconfig$report_grouping_definitions) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        write_csv("report_grouping.csv")

    #control_defs
    data_frame(values = plugin_json$pluginconfig$control_definitions) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        write_csv("control_defs.csv")

    # config file
    data_frame(values = plugin_json$pluginconfig$config_file) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = c("key", "value")) %>%
        write_csv("config_file.csv")
    }

    report_grouping = read_csv(args_custom_groups) %>%
        map_if(is.factor, as.character) %>%
        as_tibble()

    control_defs = read_csv(args_control_defs) %>%
        map_if(is.factor, as.character) %>%
        as_tibble()

    manifest = read_csv(args_run_manifest) %>%
        map_if(is.factor, as.character) %>%
        as_tibble()

    config_file = read_csv(args_config_file) %>%
        map_if(is.factor, as.character) %>%
        as_tibble()

    temp = list(manifest = manifest,
            report_grouping = report_grouping,
            control_defs = control_defs,
            config_file = config_file)



}
