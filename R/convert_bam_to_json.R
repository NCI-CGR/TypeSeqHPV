#+

convert_bam_to_json <- function(path, bam_dir){
  require(dplyr)
  system(paste0("/home/adam/sambamba view --nthreads=8 --format=json ", bam_dir, "/", path, " -o ", path,".json"))
  df = data_frame(path = unlist(path))
}
