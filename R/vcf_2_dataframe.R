#+
vcf_to_json <- function(vcf_files){
    require(dplyr)
    require(fs)

    system("/home/adam/bin/adam-shell --driver-memory 80G --driver-cores 22 -i /TypeSeqHPV/inst/methylation/vcf_to_json_adam.scala")

    vcf_files = dir_ls("vcf", recursive = TRUE, type = "file", glob = "*.json") %>%
        map_df(as_tibble) %>%
        rename(path = value)

}
