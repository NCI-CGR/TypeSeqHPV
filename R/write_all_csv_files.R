#' Write all csv outputs
#'
#' per project code pn matrices
#'   
#' Includes group/mask information. The group_by project and then do() function is esentially a loop over all the projects in the pos/neg matrix.  
#'
#' other csv outputs
#' 
#' These other outputs are by "batch" (also refered to as "sequencing run")

write_all_csv_files <- function(final_grouped_samples_only_matrix, read_metrics, final_pn_matrix, hpv_types, control_matrix, failed_samples_matrix, full_lineage_table_with_manifest){
  
################ per project code pn matrices with group/mask information ################
grouped_samples_only_matrix %>%
group_by(Project) %>%
do({
temp = as_tibble(.)
    
temp = temp[, colSums(is.na(temp)) == 0]
    
write_csv(temp, paste(temp$Project[1], temp$Assay_Batch_Code[1], "samples_only_matrix.csv", sep="_"))
}) %>%
group_by(Project, Panel) %>%
summarize(count = n())

############### other outputs that are by batch (sequencing run) ################

write_csv(read_metrics, paste0(final_pn_matrix$Assay_Batch_Code[1], "_read_metrics.csv")) 

#need to add "total_reads" column to the left of B2M
write_csv(hpv_types, paste0(final_pn_matrix$Assay_Batch_Code[1], "_hpv_read_counts_matrix.csv"))

write_csv(control_matrix, paste0(final_pn_matrix$Assay_Batch_Code[1], "_control_results.csv"))

write_csv(failed_samples_matrix %>% select(-control_type), paste0(final_pn_matrix$Assay_Batch_Code[1], "_failed_samples_matrix.csv"))

write_csv(final_pn_matrix, paste0(final_pn_matrix$Assay_Batch_Code[1], "_full_pn_matrix.csv"))

write_csv(full_lineage_table_with_manifest, paste0(final_pn_matrix$Assay_Batch_Code[1], "_lineage_matrix.csv"))
}
