#'

prepare_lineage_df <- function(args_lineage_reference_path, args_lineage_table_path, samples_only_matrix){
  
lineage_reference = read_csv(args_lineage_reference_path) %>%
mutate(type_lineage = paste0(HPV_Type, "-", Lineage_ID)) %>%
mutate(reported_type_lineage = paste0(Reported_Type, "-", Lineage_ID)) %>%
select(HPV_Type, type_lineage, reported_type_lineage, min_lineage_percent, min_lineage_read_count, min_lineage_percent_override_reads) %>%
distinct() %>%
glimpse()
  

lineage_table = stream_in(file(args_lineage_table_path)) %>%
group_by(bc1_id, bc2_id, HPV_Type) %>%
do({

temp = as_tibble(.) %>%
select(page_num, HPV_Type_count) %>%
distinct() %>%
mutate(HPV_Type_count = sum(HPV_Type_count))
  
temp_return = as_tibble(.) %>%
mutate(HPV_Type_count = temp$HPV_Type_count[1])

}) %>%
group_by(bc1_id, bc2_id, HPV_Type, Lineage_ID, lineage_tag) %>%
mutate(lineage_read_count = sum(lineage_read_count)) %>%
ungroup() %>%
select(-page_num) %>%
distinct() %>%
mutate(barcode = paste0(bc1_id, bc2_id)) %>%
mutate(lineage_percent = as.numeric(formatC(
  lineage_read_count / HPV_Type_count * 100), digits=0, format="f", drop0trailing = TRUE)) %>%
filter(lineage_tag == "full match") %>%
mutate(type_lineage = paste0(HPV_Type, "-", Lineage_ID))  %>%
merge(lineage_reference %>% select(-HPV_Type), by="type_lineage") %>%
select(-bc1_id, -bc2_id, -lineage_tag, -HPV_Type_count)

samples_only_matrix_for_merge = samples_only_matrix %>%
gather(hpvType, hpvStatus, starts_with("HPV")) %>%
arrange(barcode, hpvType) %>%
glimpse() %>%
rename(HPV_Type = hpvType) %>%
semi_join(lineage_reference, by="HPV_Type") %>%
glimpse()

lineage_table_with_mainfest = samples_only_matrix_for_merge %>%
left_join(lineage_table, by=c("barcode", "HPV_Type")) %>%
filter(!(is.na(type_lineage))) %>%
filter(hpvStatus == "pos") %>%
filter(lineage_read_count >= min_lineage_read_count | lineage_percent >= min_lineage_percent_override_reads) %>%
filter(lineage_percent >= min_lineage_percent) %>%
arrange(barcode, type_lineage) %>%
glimpse() %>%
bind_rows(lineage_reference) %>%
glimpse() 

lineage_table_with_manifest_spread = lineage_table_with_mainfest %>%
arrange(HPV_Type) %>%
select(-HPV_Type, -hpvStatus, -Lineage_ID, -lineage_read_count, 
       -min_lineage_percent,  -min_lineage_read_count, -min_lineage_percent_override_reads) %>%
group_by(barcode) %>%
spread(reported_type_lineage, lineage_percent, fill=0) %>%
filter(!(is.na(Project))) %>%
glimpse()

# find samples missing from lineage table
lineage_negative_samples = samples_only_matrix %>% 
select(-starts_with("HPV")) %>%
anti_join(select(lineage_table_with_manifest_spread, barcode)) 

# adding back in blank samples
full_lineage_table_with_manifest_spread = lineage_table_with_manifest_spread %>%
bind_rows(lineage_negative_samples) %>%
select(-Control_type) %>%
glimpse()

return(full_lineage_table_with_manifest_spread)
}
