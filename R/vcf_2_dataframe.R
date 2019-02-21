#+
vcf_to_dataframe <- function(vcf_files){
    require(tidyverse)
    require(fs)
    require(vcfR)

    temp = read.vcfR(vcf_files$vcf_out)

    temp = vcfR2tidy(temp)

    temp = temp$fix %>%
    as_tibble() %>%
    mutate(filename = vcf_files$vcf_out) %>%
    select(filename, everything())

    return(temp)


}
