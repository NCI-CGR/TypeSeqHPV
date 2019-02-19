#+
samtools_sort <- function(bam_files){
    require(tidyverse)

    #system(paste0("samtools sort ", bam_df$bam_path, " ", bam_df$sorted_path), wait = TRUE)

    system(paste0("samtools index ", paste0(bam_files$path, ".bam")), wait = TRUE)

    return(bam_files)

}

