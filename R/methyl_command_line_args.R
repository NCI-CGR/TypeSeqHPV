#'
methyl_command_line_args <- function(args_df){
    require(jsonlite)
    require(tidyverse)
    library(optigrab)

if ( args_df$is_torrent_server == "yes") {

    plugin_json = fromJSON(args_start_plugin, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

    # config file
    data_frame(values = plugin_json$pluginconfig$config_file) %>%
        mutate(values = str_replace(values, "\n", "" )) %>%
        separate(col = values, sep = ",", into = c("key", "value")) %>%
        write_csv("config_file.csv")
}

config_file_df = read_csv(args_df$config_file, col_names = c("key", "value")) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    mutate(value = paste0("/user_files/", value)) %>%
    glimpse()

new_args_df = args_df %>%
    gather() %>%
    anti_join(config_file_df, by = "key") %>%
    bind_rows(config_file_df) %>%
    spread("key", "value") %>%
    glimpse()

return(new_args_df)

}




