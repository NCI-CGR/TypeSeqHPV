#+
adam_demux <- function(user_files, ram, cores){
    require(dplyr)
    require(fs)

    system(paste0("/home/adam/bin/adam-shell --driver-memory ", ram," --driver-cores ",cores," -i /TypeSeqHPV/inst/methylation/demux_3prime_barcode_adam.scala"))

    return(
        dir_ls("./", glob = "demux*.bam") %>%
        map_df(as_tibble) %>%
        rename(path = value) %>%
        glimpse())

}


