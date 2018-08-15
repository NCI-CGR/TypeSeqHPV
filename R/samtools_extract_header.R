#+

extract_header <- function(path, bam_dir){
  require(dplyr)
  system(paste0("samtools view ", bam_dir, "/", path, " -H -o bam_header.txt"))
  df = data_frame(path = "bam_header.txt")
}  

