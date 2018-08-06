#'
plugin_manifest_parse <- function(args_start_plugin){
require(jsonlite)
require(tidyverse)

plugin_json = fromJSON(args_start_plugin_path, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

manifest = data_frame(values = plugin_json$pluginconfig$typing_manifest) %>%
mutate(values = str_replace(values, "\n", "" )) %>%
separate(col=values, sep=",", into = unlist(str_split(.$values[1], ","))) %>%
slice(2:n()) %>%
write_csv("typing_manifest.csv")

}
