#+

create_bam_json <- function(bam_file_input, bam_dir) {
  
bam_json_func <- function(path, bam_dir){
  system(paste0("/sambamba view --nthreads=8 --format=json ", bam_dir, "/", path, " -o ", path,".json"))
}  

temp = bam_file_input %>%
mutate(name = path) %>%
do({
  temp = as_tibble(.)
  
  parallel::mclapply(temp$path, bam_json_func, bam_dir = bam_dir, mc.cores=detectCores()-1)

  temp = temp

}) %>%
glimpse()

}
