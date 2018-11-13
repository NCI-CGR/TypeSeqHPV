#+
tvc_cli <- function(files){
    require(dplyr)
    require(fs)

    vcf_df = files %>%
        as_tibble() %>%
        separate(path, "sorted_bams/", into = c("temp", "sample_name"), remove = FALSE) %>%
        select(-temp) %>%
        separate(sample_name, ".sorted.bam", into = c("sample_name"), extra = 'drop') %>%
        mutate(vcf = paste0("vcf/", sample_name, ".vcf")) %>%
        rename(bam_path = path)

    system(paste0("tvc --error-motifs /opt/tvc-5.10.1/share/TVC/sse/motifset.txt \\
    --output-vcf ", vcf_df$vcf, " \\
    --input-bam ", vcf_df$bam_path, " \\
    --force-sample-name ", vcf_df$sample_name, " \\
    --input-vcf /plugin/Methyl_HOTSPOT_T28_complete_v2_VCF.vcf \\
    --reference /plugin/HPV-Methyl_REF_T28.fasta \\
    --target-file /plugin/Methyl_INSERT-REGIONS_T28_3.bed \\
    --trim-ampliseq-primers \\
    --parameters-file /plugin/methyl_T28_4_TVCparameters.json \\
    --num-threads 4"))

    system("rm vcf/*filtered.vcf")

    vcf_df = vcf_df

    }

#     -s 1 -m 2  \\
