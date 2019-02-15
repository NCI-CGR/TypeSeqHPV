#+
samtools_sort <- function(bam_files){
    require(tidyverse)

    bam_df = bam_files %>%
        as_tibble() %>%
        #separate(path, "./", into = c("temp", "bam"), remove = FALSE) %>%
        #select(-temp) %>%
        mutate(bam = path) %>%
        separate(bam, ".bam", into = c("bam"), extra = 'drop') %>%
        rename(bam_path = path) %>%
        mutate(sorted_path = paste0("sorted_bams/", bam,".sorted"))

    system(paste0("samtools sort ", bam_df$bam_path, " ", bam_df$sorted_path), wait = TRUE)


    system(paste0("samtools index ", paste0(bam_df$sorted_path, ".bam")), wait = TRUE)

    return(bam_df)

}

