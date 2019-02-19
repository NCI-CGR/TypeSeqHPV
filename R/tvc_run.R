#+
tvc_cli <- function(files, args_df){
    require(dplyr)
    require(fs)

    vcf_df = files %>%
        mutate(vcf = paste0("vcf/", barcode, ".vcf")) %>%
        glimpse()

    system(paste0("tvc --error-motifs /opt/tvc-5.10.1/share/TVC/sse/motifset.txt \\
    --output-vcf ", vcf_df$vcf, " \\
    --input-bam ", vcf_df$path, " \\
    --sample-name ", vcf_df$barcode, " \\
    --input-vcf ", args_df$hotspot_vcf, " \\
    --reference ", basename(args_df$reference), " \\
    --target-file ", args_df$region_bed, " \\
    --parameters-file ", args_df$tvc_parameters, " \\
    --trim-ampliseq-primers \\
    --num-threads 4"))

    #system("rm vcf/*filtered.vcf")

    return(vcf_df)

    }
