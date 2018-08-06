#+

ion_read_processor_apply <- function(bam_json, args_lineage_reference, args_barcode_list, parameters_df){

require(TypeSeqHPV)         
         
temp = bam_json %>%
filter(!(str_detect(path, "bam.json"))) %>%
mutate(path = paste0(path, ".json")) %>%
glimpse() %>%
do({
temp = as_tibble(.)  

mclapply(temp$path, ion_read_processor, 
         args_lineage_reference_path=args_lineage_reference,
         args_barcode_list=args_barcode_list, 
         parameters_df=parameters_df, mc.cores=4) 
  
system("cat *read_metrics.json > read_metrics_merged.json")  
#system("cat *hpv_lineage.json > hpv_lineage_merged.json")  
#system("cat *bc2_demultiplex.json > bc2_demultiplex_merged.json")  

temp = temp
})
}
