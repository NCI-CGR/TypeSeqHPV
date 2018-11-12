#+
adam_vcf_2_json <- function(bam_dir, bam_files){
    require(dplyr)
    require(fs)

    system("/home/adam/bin/adam-shell -i /package/inst/methylation/demux_3prime_barcode_adam.scala")
    system("mkdir vcf_json")
    #system("mv */*A*bam demux_bams")
    #system("rm -R *_demux")

    return_df = dir_ls("vcf_json", glob = "*.json") %>%
        map_df(as_tibble) %>%
        rename(path = value) %>%
        glimpse()
}
