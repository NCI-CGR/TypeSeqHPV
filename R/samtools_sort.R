#+
samtools_sort <- function(bam_files){
    require(tidyverse)

    system(paste0("samtools view -bhR ", bam_files$read_group_path," demux_reads.bam > ",
                  bam_files$bam_path), wait = TRUE)

    system(paste0("samtools sort ", bam_files$bam_path, " ", bam_files$sample, "_sorted"), wait = TRUE)

    system(paste0("samtools index ", temp$sorted_path), wait = TRUE)

    return(bam_files)

}

