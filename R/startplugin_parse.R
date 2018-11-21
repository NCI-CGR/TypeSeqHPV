#'
startplugin_parse <- function(args_start_plugin){
    require(jsonlite)
    require(tidyverse)

    plugin_json = fromJSON(args_start_plugin, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

    #manifest
    data_frame(values = plugin_json$pluginconfig$typing_manifest) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        glimpse() %>%
        write_csv("typing_manifest.csv")

    #report_grouping
    data_frame(values = plugin_json$pluginconfig$report_grouping_definitions) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        glimpse() %>%
        write_csv("report_grouping.csv")

    #control_defs
    data_frame(values = plugin_json$pluginconfig$control_definitions) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        glimpse() %>%
        write_csv("control_defs.csv")

    # config file
    data_frame(values = plugin_json$pluginconfig$config_file) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = c("key", "value")) %>%
        slice(2:n()) %>%
        glimpse() %>%
        write_csv("config_file.csv")

}
