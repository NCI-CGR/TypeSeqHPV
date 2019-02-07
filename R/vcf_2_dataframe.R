#+
vcf_to_dataframe <- function(vcf_files){
    require(tidyverse)
    require(fs)
    require(VCFWrenchR)
    require(VariantAnnotation)
    require(import)

    import::from(dplyr, select)

    #detach("package:drake", unload = TRUE)

    temp = as.data.frame(readVcf(vcf_files$vcf)) %>%
    as_tibble() %>%
    mutate(filename = vcf_files$vcf) %>%
    select(filename, everything()) %>%
    select(-ends_with(".bam"))

    #require(drake)

    return(temp)


}
