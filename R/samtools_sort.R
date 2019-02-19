#+
samtools_sort <- function(bam_files){
    require(tidyverse)


    temp = bam_files %>%
        ungroup() %>%
        select(path) %>%
        distinct()

    #system(paste0("samtools sort ", bam_df$bam_path, " ", bam_df$sorted_path), wait = TRUE)

    system(paste0("samtools index ", temp$path), wait = TRUE)

    return(bam_files)

}

