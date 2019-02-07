#+
adam_demux <- function(...){
    require(dplyr)
    require(fs)

    system("/home/adam/bin/adam-shell --driver-memory 80G --driver-cores 22 -i /TypeSeqHPV/inst/methylation/demux_3prime_barcode_adam.scala")
    system("mkdir demux_bams")
    system("mv *.bam_demux/*.bam demux_bams")
    system("rm -R *_demux")

    return(
        dir_ls("demux_bams", glob = "*.bam") %>%
        map_df(as_tibble) %>%
        rename(path = value) %>%
        glimpse())

}


