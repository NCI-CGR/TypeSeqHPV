tvc_single <- function(files, args_df){ 
  require(dplyr) 
  require(fs) 
  
  vcf_df = files %>% 
    mutate(vcf_out = paste0("vcf/", sample, ".vcf")) %>% 
    glimpse() 
  
  system(paste0("tvc --error-motifs /opt/tvc-5.10.1/share/TVC/sse/motifset.txt \\ 
        --output-vcf ", vcf_df$vcf_out, " \\ 
        --input-bam ", vcf_df$bam_path, " \\ 
        --sample-name ", vcf_df$sample, " \\ 
        --input-vcf ", args_df$hotspot_vcf, " \\ 
        --reference ", basename(args_df$reference), " \\ 
        --target-file ", args_df$region_bed, " \\ 
        --parameters-file ", args_df$tvc_parameters, " \\ 
        --trim-ampliseq-primers \\ 
        --num-threads ", args_df$tvc_cores)) 
  
  system("rm vcf/*filtered.vcf") 
  
  return(vcf_df) 
  
}        