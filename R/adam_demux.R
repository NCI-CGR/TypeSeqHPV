#+
adam_demux <- function(bam_dir, bam_files){
    require(dplyr)
    require(fs)

    system("/home/adam/bin/adam-shell --driver-memory 80G --driver-cores 22 -i /TypeSeqHPV/inst/methylation/demux_3prime_barcode_adam.scala")
    system("mkdir demux_bams")
    system("mv */*A*bam demux_bams")
    system("rm -R *_demux")

    return_df = dir_ls("demux_bams", glob = "*.bam") %>%
        map_df(as_tibble) %>%
        rename(path = value) %>%
        glimpse()
}


