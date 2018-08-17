#+
extract_header <- function(bam_dir, bam_files){
  require(dplyr)
  system(paste0("samtools view ", bam_dir, "/", bam_files$path[1], " -H -o bam_header.txt"))
  df = data_frame(path = "bam_header.txt")
}  
