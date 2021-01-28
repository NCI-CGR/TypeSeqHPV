create_hpv_types_table <- function(hpv_types_json_path, run_manifest_path, bam_header, parameters_df){

hpv_type_counts = stream_in(file("bc2_demultiplex_merged.json")) %>%
mutate(barcode = paste0(bc1_id, bc2_id)) %>%
group_by(barcode, HPV_Type) %>%
mutate(HPV_Type_count = sum(HPV_Type_count)) %>%
ungroup() %>%
select(barcode, bc1_id, HPV_Type, HPV_Type_count) %>%
distinct() %>%
group_by(bc1_id) %>%
mutate(qualified_aligned_reads = sum (HPV_Type_count)) %>%
ungroup() %>%
arrange(barcode, HPV_Type) 

#create hpv types longform
hpv_types_long = read_csv(run_manifest_path, col_names=TRUE) %>%
filter(!is.na(Owner_Sample_ID)) %>%
mutate(barcode = paste0(BC1, BC2)) %>%
select(-BC1,-BC2)  %>%
left_join(hpv_type_counts, by="barcode") 

#create hpv types dataframe
hpv_types = hpv_types_long %>%
bind_rows(bam_header) %>% # <- bind with bam header to get contig names that might be absent from all samples in this particular run
left_join(parameters_df) %>% # <- merge with parameters file to get display order
mutate(HPV_Type = factor(HPV_Type, levels=unique(HPV_Type[order(display_order)]), ordered=TRUE)) %>%
select(-display_order) %>%
group_by(barcode) %>% # <- adding total reads column to the left of b2m
mutate(total_reads = sum(HPV_Type_count)) %>%
spread(HPV_Type, HPV_Type_count, fill = "0") %>% # <- tranform from long form to actual matrix
filter(!is.na(Project)) %>%
do({
    temp = .
    if ("<NA>" %in% colnames(temp)){temp = temp %>% select(-`<NA>`)}
    temp = temp
}) %>%
mutate_at(vars(starts_with("HPV")), funs(as.numeric(.))) %>% # <- change columns back to numeric
mutate_at(vars(starts_with("B2M")), funs(as.numeric(.))) %>%
mutate(HPV64 = HPV34 + HPV64) %>% # <- condense/merge contigs that are from the same type
mutate(HPV54 = HPV54 + HPV54_B_C_consensus) %>%
mutate(HPV74 = HPV74 + HPV74_EU911625 + HPV74_EU911664 + HPV74_U40822) %>%
select(-HPV34, -HPV54_B_C_consensus, -HPV74_EU911625, -HPV74_EU911664, -HPV74_U40822) 
  
return(hpv_types)  
}  
