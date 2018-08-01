#'
create_full_run_read_metrics_df <- function(read_metrics_path, hpv_type_counts){
  
read_metrics = stream_in(file("read_metrics_merged.json")) %>%
group_by(bc1_id, file_name) %>%
do({
df = .

df = df %>%
mutate(total_reads = sum(total_reads)) %>%
mutate(mapq_greater_than_zero = sum(mapq_greater_than_zero)) %>%
mutate(pass_za = sum(pass_za)) %>%
mutate(pass_seq_length = sum(pass_seq_length)) %>%
mutate(pass_mapq = sum(pass_mapq)) %>%
distinct()
}) %>%
ungroup() %>%
select(-page_num) %>%
select(bc1_id, total_reads, mapq_greater_than_zero, pass_za, pass_seq_length, pass_mapq, file_name) %>%
distinct() %>%
left_join(hpv_type_counts %>% select(bc1_id, qualified_aligned_reads) %>% distinct()) %>%
mutate(mapq_gtz_p = mapq_greater_than_zero / total_reads) %>%
mutate(pass_za_p = pass_za / total_reads) %>%
mutate(pass_seq_length_p = pass_seq_length / total_reads) %>%
mutate(pass_mapq_p = pass_mapq / total_reads) %>%
mutate(qualified_p = qualified_aligned_reads / total_reads) %>%
select(file_name, mapq_gtz_p, pass_za_p, pass_seq_length_p, pass_mapq_p, qualified_p, total_reads, mapq_greater_than_zero, pass_za, pass_seq_length, pass_mapq, qualified_aligned_reads) %>%
distinct() %>%
glimpse()
}
