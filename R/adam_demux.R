#+
adam_demux <- function(bam_dir, bam_files){
    require(dplyr)
    system("/home/adam/bin/adam-shell -i /data/inst/methylation/demux_3prime_barcode_adam.scala")
    system("mkdir demux_bams")
    system("mv */*A*bam demux_bams")
    system("rm -R *_demux")

    df = data_frame(path = bam_dir)
}
