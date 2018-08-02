#+

create_bam_json <- function(bam_file_input) {
  
bam_json_func <- function(path){
  system(paste0("./sambamba view --nthreads=8 --format=json ", path, " -o ", path,".json"))
}  

temp = bam_file_input %>%
mutate(name = path) %>%
do({
  temp = as_tibble(.)
  
  parallel::mclapply(temp$path, bam_json_func, mc.cores=8)

  temp = temp

}) %>%
glimpse()

}
