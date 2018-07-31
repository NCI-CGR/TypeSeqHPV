#+

ts_read_metrics <- function(bam_json_input, parameters_df_input, page){

# only used in a jsonlite streaming function

if("ZA" %in% colnames(bam_json_input$tags)){ ZA_df = data_frame(ZA = bam_json_input$tags$ZA)}else{ZA_df = data_frame(ZA = rep(0, length(bam_json_input$qname)))}

bam_json = bam_json_input %>%
select(qname, HPV_Type = rname, seq, mapq, cigar) %>%
mutate(page_num = page) %>%
bind_cols(ZA_df) %>%
mutate(ZA = ifelse(is.na(ZA), 0, ZA)) %>%
mutate(bc1_id = args_A_barcode) %>%
mutate(file_name = args_bam_json$name) %>%
mutate(total_reads = n()) %>%
  
# left join with parameters file that contians qualifying criteria for each hpv contig
left_join(parameters_df_input) %>%
  
# mapq greater than 0 - count multi-mapped / 0 mapping quaity and filter becuase cigar will be 0 so we cannot include past here
mutate(mapq_greater_than_zero = ifelse(mapq != 0, 1, 0)) %>%
mutate(mapq_greater_than_zero = sum(mapq_greater_than_zero)) %>%
filter(mapq > 0) %>%
  
# ZA
mutate(pass_za = ifelse(str_length(seq) == ZA, 1, 0)) %>%
  
# aligned length within specific parameters
mutate(cigar_seq = as.character(sequenceLayer(DNAStringSet(seq), cigar))) %>%
mutate(cigar_len = str_length(cigar_seq)) %>%
mutate(pass_seq_length = ifelse(
  cigar_len >= min_len, ifelse(
  cigar_len <= max_len, ifelse(
  pass_za == 1, 1, 0), 0), 0)) %>%
  
# mapq is greater than specific parameters
mutate(pass_mapq = ifelse(mapq >= mq, 1, 0)) %>%

mutate(pass_mapq = ifelse(
  mapq >= mq, ifelse(
  pass_seq_length == 1, ifelse(
  pass_za == 1, 1, 0), 0), 0)) %>%

# sum up
mutate(pass_za = sum(pass_za)) %>%
mutate(pass_seq_length = sum(pass_seq_length)) %>%
mutate(pass_mapq = sum(pass_mapq)) %>%
# select the final colums and compress down to 1 row with distinct()
select(page_num, bc1_id, total_reads, mapq_greater_than_zero, pass_za, pass_seq_length, pass_mapq, file_name) %>%
distinct()
  
    
}
