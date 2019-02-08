#+
adam_demux <- function(user_files, ram, cores){
    require(dplyr)
    require(fs)

    system(paste0("/home/adam/bin/adam-shell --driver-memory ", ram," --driver-cores ",cores," -i /TypeSeqHPV/inst/methylation/demux_3prime_barcode_adam.scala"))
    system("mkdir demux_bams")
    system("mv *.bam_demux/*.bam demux_bams")
    system("rm -R *_demux")
    system("cp read_summary_df.csv/*csv read_summary.csv")
    system("cp hamming_summary_df.csv/*csv hamming_summary.csv")


    return(
        dir_ls("demux_bams", glob = "*.bam") %>%
        map_df(as_tibble) %>%
        rename(path = value) %>%
        glimpse())

}


