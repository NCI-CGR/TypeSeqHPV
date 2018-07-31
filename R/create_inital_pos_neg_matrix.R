#'

create_inital_pos_neg_matrix <- function(hpv_types, factoring_table, filtering_criteria) {

# read in hpv_types and left join with filtering criteria csv
pn_matrix = hpv_types %>%
tidyr::gather("type_id", "read_counts", starts_with("HPV")) %>%
left_join(filtering_criteria) %>%

# calculate total reads and individual type percentage
group_by(barcode) %>%
mutate(hpv_total_reads = sum(read_counts)) %>%
ungroup() %>%
mutate(type_perc = read_counts / hpv_total_reads) %>%

# set b2m_status
mutate(b2m_status = ifelse((B2M >= factoring_table$B2M_min) | hpv_total_reads >=1000, "pass", "fail")) %>%

# now we set type status to positve and sequentially set to negative if any filters are failed
mutate(type_status = "pos") %>%
mutate(type_status = ifelse(hpv_total_reads >= 1000, type_status, "neg"))  %>%
mutate(type_status = ifelse(read_counts >= factored_min_reads_per_type, type_status, "neg"))  %>%
mutate(type_status = ifelse(type_perc >= Min_type_percent_hpv_reads, type_status, "neg")) %>%
group_by(barcode) %>%
mutate(Num_Types_Pos = if_else(type_status == "pos", 1, 0)) %>%
mutate(Num_Types_Pos = sum(Num_Types_Pos)) %>%
mutate(Human_Control = ifelse(b2m_status == "fail", "failed_to_amplify", b2m_status)) %>%
select(-mq, -min_len, -max_len) %>%
   
ungroup() %>%

# spread back into matrix format
select(-b2m_status, -Min_reads_per_type, -factored_min_reads_per_type, -qualified_aligned_reads, -hpv_total_reads, -type_perc, -Min_type_percent_hpv_reads, -read_counts, -B2M) %>%

# This keeps the proper column order
mutate(type_id = factor(type_id,levels=filtering_criteria$type_id)) %>%
ungroup() %>%
spread(type_id, type_status, fill="neg") %>%
arrange(barcode)
  
return(pn_matrix)
}
