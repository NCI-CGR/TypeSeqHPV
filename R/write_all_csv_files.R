#' Write all csv outputs
#'
#' per project code pn matrices
#'
#' Includes group/mask information. The group_by project and then do() function is esentially a loop over all the projects in the pos/neg matrix.
#'
#' other csv outputs
#'
#' These other outputs are by "batch" (also refered to as "sequencing run")

write_all_csv_files <- function(final_grouped_samples_only_matrix, read_metrics, final_pn_matrix, hpv_types, control_matrix, failed_samples_matrix, full_lineage_table_with_manifest, parameters_df){

################ per project code pn matrices with group/mask information ################
final_grouped_samples_only_matrix %>%
    select(Project, Assay_Batch_Code, Assay_Plate_Code, Owner_Sample_ID,
           Barcode = barcode, Human_control = Human_Control,
           Num_Types_Pos = not_masked_and_not_grouped_Num_Types_Pos,
           starts_with("HPV")) %>%
    glimpse() %>%
    group_by(Project) %>%
    do({
      temp = as_tibble(.)

      batch_code = temp$Assay_Batch_Code[1]

      temp = temp %>%
        select(-Assay_Batch_Code) %>%
        mutate(filename = paste(.$Project, batch_code,
                            "samples_only_matrix.csv", sep = "_"))

      output = temp %>%
        select(-filename)

      output = output[, colSums(is.na(output)) == 0]

      write_csv(output, temp$filename[1])

      temp = temp
    })


############### other outputs that are by batch (sequencing run) ################

## correct column order in reads matrix

hpv_types = hpv_types %>%
select(-bc1_id, -qualified_aligned_reads, -mq, -min_len, -max_len) %>%
gather("HPV_Type", "read_counts", starts_with("HPV")) %>%
left_join(parameters_df %>% select(HPV_Type, display_order)) %>% # <- merge with parameters file to get display order
mutate(HPV_Type = factor(HPV_Type, levels = unique(HPV_Type[order(display_order)]), ordered = TRUE)) %>%
select(-display_order) %>%
group_by(barcode) %>%
spread(HPV_Type, read_counts) # <- tranform from long form to actual matrix


### Changes to address the issue # 85
# a. hpv_reads would be calculated by subtracting the b2m count from total_reads.b. hpv_type would be one of the 54 specific types assayed (ie, HPV03, HPV06, etc.)
# c. call would be the pos or neg call for the sample and type specified in the row (same as specified in the full_pn_matrix file)
# d. read_count is the type-specific read count from the read_counts_matrix file, for the sample and hpv type specified in the row
# e. read_proportion is calculated by dividing the read_count by hpv_reads

# Take A:X columns from hpv_types, and convert the table to long form
# Join with the table final_pn_matrix



pn_count_long <- hpv_types %>% mutate(hpv_reads = total_reads - B2M) %>% 
   # Insert Control_type, control_result, Num_Types_Pos, and Human_Control
   # between hpv_reads and hpv_type
   left_join(
      final_pn_matrix %>% select(barcode, Control_type:Human_Control), by=c("barcode")
   ) %>%
   gather("hpv_type", "read_count", starts_with("HPV", ignore.case=F)) %>% 
   mutate(read_proportion = read_count/hpv_reads) %>% 
  
   # join with the final_pn_matrix to have the call
   inner_join(
     final_pn_matrix %>% select(barcode, starts_with("HPV")) %>% gather("hpv_type", "call", starts_with("HPV")) , by=c("barcode", "hpv_type")
    ) 


# Save to [Exp]_calls_and_read_counts.csv
write_csv(pn_count_long, paste0(final_pn_matrix$Assay_Batch_Code[1], "_calls_and_read_counts.csv"))

### End of #85

write_csv(read_metrics, paste0(final_pn_matrix$Assay_Batch_Code[1], "_read_metrics.csv"))

#need to add "total_reads" column to the left of B2M
write_csv(hpv_types, paste0(final_pn_matrix$Assay_Batch_Code[1], "_hpv_read_counts_matrix.csv"))

write_csv(control_matrix, paste0(final_pn_matrix$Assay_Batch_Code[1], "_control_results.csv"))

write_csv(failed_samples_matrix, paste0(final_pn_matrix$Assay_Batch_Code[1], "_failed_samples_matrix.csv"))

write_csv(final_pn_matrix, paste0(final_pn_matrix$Assay_Batch_Code[1], "_full_pn_matrix.csv"))

write_csv(full_lineage_table_with_manifest, paste0(final_pn_matrix$Assay_Batch_Code[1], "_lineage_matrix.csv"))
}
