#+

create_bam_json <- function(bam_file_input) {

temp = bam_file_input %>%
mutate(name = path) %>%
do({
  temp = as_tibble(.)
  
  parallel::mclapply(temp$path, bam_json_func, mc.cores=8)

  temp = temp

}) %>%
glimpse()

}
