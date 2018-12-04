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
    select(Project, Assay_Batch_Code, Owner_Sample_ID,
           Barcode = barcode, Human_control = Human_Control,
           Num_Types_Pos = not_masked_and_not_grouped_Num_Types_Pos,
           starts_with("HPV")) %>%
    glimpse() %>%
    group_by(Project) %>%
    do({
      temp = as_tibble(.) %>%
        mutate(filename = paste(.$Assay_Batch_Code[1],
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



write_csv(read_metrics, paste0(final_pn_matrix$Assay_Batch_Code[1], "_read_metrics.csv"))

#need to add "total_reads" column to the left of B2M
write_csv(hpv_types, paste0(final_pn_matrix$Assay_Batch_Code[1], "_hpv_read_counts_matrix.csv"))

write_csv(control_matrix, paste0(final_pn_matrix$Assay_Batch_Code[1], "_control_results.csv"))

write_csv(failed_samples_matrix, paste0(final_pn_matrix$Assay_Batch_Code[1], "_failed_samples_matrix.csv"))

write_csv(final_pn_matrix, paste0(final_pn_matrix$Assay_Batch_Code[1], "_full_pn_matrix.csv"))

write_csv(full_lineage_table_with_manifest, paste0(final_pn_matrix$Assay_Batch_Code[1], "_lineage_matrix.csv"))
}
