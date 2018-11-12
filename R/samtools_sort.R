#+
samtools_sort <- function(bam_files){
    require(tidyverse)

    bam_df = bam_files %>%
        as_tibble() %>%
        separate(path, "demux_bams/", into = c("temp", "bam"), remove = FALSE) %>%
        select(-temp) %>%
        separate(bam, ".rawlib.bam", into = c("bam"), extra = 'drop') %>%
        rename(bam_path = path) %>%
        mutate(sorted_path = paste0("/mnt/sorted_bams/", bam,".sorted.bam"))

    system(paste0("samtools sort -f /mnt/", bam_df$bam_path, " ", bam_df$sorted_path))

    system(paste0("samtools index ", bam_df$sorted_path))

    bam_df = bam_df
}








