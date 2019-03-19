#'
methyl_startplugin_parse <- function(args_df){
    require(jsonlite)
    require(tidyverse)

if ( args_df$is_torrent_server == "yes") {

    plugin_json = fromJSON(file("./startplugin.json"), simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

    #manifest
    data_frame(values = plugin_json$pluginconfig$typing_manifest) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = unlist(str_split(.$values[1], ","))) %>%
        slice(2:n()) %>%
        glimpse() %>%
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
        glimpse() %>%
        write_csv("barcodes.csv")

}

manifest = read_csv(args_df$manifest) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    glimpse()

control_defs = read_csv(args_df$control_definitions) %>%
    map_if(is.factor, as.character) %>%
    as_tibble()  %>%
    glimpse()

barcode_file = read_csv(args_df$barcode_file) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    glimpse()

#return list output

return(list(manifest = manifest,
            barocde_file = barcode_file,
            control_definitions = control_defs
            ))



}


