#+

ts_demultiplex_bc2 = function(bam_json_input, parameters_df_input, barcode_list, page, lineage_reference_table){

if("ZA" %in% colnames(bam_json_input$tags)){ ZA_df = data_frame(ZA = bam_json_input$tags$ZA)}else{ZA_df = data_frame(ZA = rep(0, length(bam_json_input$qname)))}

bam_json = bam_json_input %>%
select(qname, HPV_Type = rname, seq, mapq, cigar) %>%
mutate(page_num = page) %>%
bind_cols(ZA_df) %>%
mutate(ZA = ifelse(is.na(ZA), 0, ZA)) %>%
mutate(bc1_id = args_A_barcode) %>%
mutate(file_name = bam_json_input$name) %>%
mutate(total_reads = n()) %>%
mutate(seq_length = str_length(seq)) %>%
left_join(parameters_df) %>%

# Filter 1 - mapq > 0 ----
filter(mapq > 0) %>%
  
# Filter 2 - ZA  ----
filter(str_length(seq) == ZA) %>%

# Filter 3 - aligned length within specific parameters ----
mutate(cigar_seq = as.character(sequenceLayer(DNAStringSet(seq), cigar))) %>%
mutate(cigar_len = str_length(cigar_seq)) %>%
filter(cigar_len >= min_len & cigar_len <= max_len) %>%

# Filter 4 - mapq is greater than specific parameters ----
filter(mapq >= mq)

 # filter 5 - barcode is perfect match ----

bam_json_with_barcode = barcode_list %>%
select(bc2_id = id, bc_sequence = sequence, bc_adapter = adapter) %>%
filter(str_sub(bc2_id, end =1) == "P") %>%
mutate(bc_length = str_length(bc_sequence)) %>%
group_by(bc2_id, bc_sequence) %>%
do({
bc_length = .$bc_length
bc_sequence = .$bc_sequence

bam_json_temp = bam_json %>%
mutate(three_prime_seq = str_sub(seq, start = -(bc_length))) %>%
filter(three_prime_seq == bc_sequence)

}) %>%
ungroup() %>%
mutate(qualified_barcode_reads = n()) %>%
group_by(file_name, bc1_id, bc2_id, HPV_Type) %>%
mutate(HPV_Type_count = n()) %>%
ungroup()

### lineage for 2017 ###
lineage_output = bam_json_with_barcode %>%
select(bc1_id, bc2_id, qname, HPV_Type, mapq, cigar_seq, HPV_Type_count) %>%
inner_join(lineage_reference_table, by = "HPV_Type") %>%
mutate(lineage_tag = "No value") %>% 
mutate(lineage_tag = ifelse(str_sub(cigar_seq, Base_num, Base_num) == Base_ID,
                            paste0(HPV_Type,"_", Lineage_ID), "undetermined")) %>%
group_by(qname, HPV_Type, Lineage_ID) %>%
mutate(lineage_tag = paste(lineage_tag, collapse = ",")) %>%
ungroup() %>%
select(bc1_id, bc2_id,qname, HPV_Type, Lineage_ID, lineage_tag, cigar_seq, mapq, HPV_Type_count) %>%
distinct() %>%
mutate(total_reads = n()) %>%
mutate(lineage_tag = ifelse(str_detect(lineage_tag, "undetermined"), "undetermined", "full match")) %>%
group_by(bc1_id, bc2_id, HPV_Type, Lineage_ID, lineage_tag) %>% 
mutate(lineage_read_count = n()) %>%
ungroup() %>%
mutate(page_num = page) %>%
select(bc1_id, bc2_id, page_num, HPV_Type, Lineage_ID, lineage_tag, lineage_read_count, HPV_Type_count) %>%
distinct()
####   
  
#### finish the bc2 demultiplex df ####
hpv_types_output = bam_json_with_barcode %>%  
select(file_name, page_num, bc1_id, bc2_id, qualified_barcode_reads, HPV_Type, HPV_Type_count, display_order) %>%
distinct()
  
### make a list output ###
output = list(hpv_types_output = hpv_types_output, lineage_output = lineage_output)

}
