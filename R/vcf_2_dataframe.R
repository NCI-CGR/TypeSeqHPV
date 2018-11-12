#+
vcf_to_json <- function(vcf_files){
    require(dplyr)
    require(fs)

    system("/home/adam/bin/adam-shell -i /package/inst/methylation/vcf_to_json_adam.scala")
    system("mkdir vcf_json")
    #system("mv vcf/*/A*.json vcf_json")
    #system("rm -R vcf/*_json_temp")

    vcf_files = dir_ls("vcf", recursive = TRUE, type = "file", glob = "*.json") %>%
        map_df(as_tibble) %>%
        rename(path = value)



}
