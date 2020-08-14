#+
adam_demux <- function(user_files, ram, cores){
  require(dplyr)
  require(fs)
  
  system(paste0("/home/adam/bin/adam-shell --driver-memory 100G --driver-cores ",cores," -i /TypeSeqHPV/inst/methylation/demux_3prime_barcode_adam.scala"))
  
  system(paste0("samtools index demux_reads.bam"), wait = TRUE)
  
  system(paste0("ls /mnt/demux_reads.bam | xargs -n1 -P4 samtools index"),wait = TRUE)
  
  system("cp read_summary_df.csv/*csv read_summary.csv")
  
  dir_ls("./", recursive = T, glob = "*.csv") %>%
    map_df(as_tibble)  %>%
    rename(path = value) %>%
    filter(str_detect(path, "sampleNames")) %>%
    group_by(path) %>%
    do({
      temp = as_tibble(.)
      
      read_csv(temp$path, col_names = "read_group") %>%
        map_if(is.factor, as.character) %>%
        as_tibble()
    }) %>%
    ungroup() %>%
    glimpse() %>%
    mutate(sample = str_sub(read_group, end = 6)) %>%
    mutate(bam_path = paste0(sample, ".bam")) %>%
    mutate(sorted_path = paste0(sample, "_sorted.bam")) %>%
    mutate(read_group_path = paste0(sample, "_rg.txt")) %>%
    group_by(read_group) %>%
    do({
      temp = as_tibble(.)
      
      temp %>%
        select(read_group) %>%
        write_csv(temp$read_group_path, col_names = FALSE)
      
      temp = temp
      
    }) %>%
    glimpse()
  
  
}


