get_run_metadata <- function(args_df){

require(tidyverse)
require(pander)
require(jsonlite)

    
    if ( args_df$is_torrent_server == "yes") {
plugin_json = fromJSON(file("./startplugin.json"), simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

    run_info = data_frame(
        run_name = plugin_json$plan$planName,
        analysis_name = plugin_json$expmeta$results_name,
        run_date = plugin_json$expmeta$run_date,
        run_type = plugin_json$runplugin$run_type,
        run_plan_notes = plugin_json$expmeta$notes,
        instrument_name = plugin_json$expmeta$instrument,
        sequencing_kit_name = plugin_json$plan$sequencekitname,
        templating_kit_name = plugin_json$plan$templatingKitName,
        chip_type = plugin_json$runinfo$chipType,
        chip_barcode = plugin_json$expmeta$chipBarcode) %>%
        gather('field name', value) %>%
        ungroup() %>%
        mutate(value = ifelse(str_length(value) > 50,
                              str_sub(value, end = 50), value)) %>%
        write_csv("run_info.csv")

    pandoc.table(run_info, style = "multiline", justify = c('right', 'left'),
                 caption = "Run Metadata", use.hyphening = TRUE)

return(run_info)

}
}