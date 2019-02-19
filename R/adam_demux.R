#+
adam_demux <- function(user_files, ram, cores){
    require(dplyr)
    require(fs)

    system(paste0("/home/adam/bin/adam-shell --driver-memory ", ram," --driver-cores ",cores," -i /TypeSeqHPV/inst/methylation/demux_3prime_barcode_adam.scala"))


    dir_ls("./", recursive = T, glob = "*.csv") %>%
        map_df(as_tibble)  %>%
        rename(path = value) %>%
        filter(str_detect(path, "sampleNames_")) %>%
        group_by(path) %>%
        do({
            temp = as_tibble(.)

            read_csv(temp$path, col_names = "barcode") %>%
            map_if(is.factor, as.character) %>%
            as_tibble()
        }) %>%
        ungroup() %>%
        mutate(barcode = str_sub(barcode, start = -6)) %>%
        separate(path, into = c("path"), sep = "/") %>%
        separate(path, into = c("temp", "path"), sep = "sampleNames_") %>%
        select(-temp) %>%
        mutate(path = paste0("demux_", path)) %>%
        glimpse()


}



