#+
vcf_to_dataframe <- function(vcf_files){
    require(dplyr)
    require(fs)
    require(VCFWrenchR)

    temp = as.data.frame(readVcf(vcf_files$path))

    return(temp)


}
