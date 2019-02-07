#+
vcf_to_dataframe <- function(vcf_files){
    require(dplyr)
    require(fs)
    require(VCFWrenchR)
    require(VariantAnnotation)

    detach("package:drake", unload = TRUE)

    temp = as.data.frame(readVcf(vcf_files$path))

    require(drake)

    return(temp)


}
