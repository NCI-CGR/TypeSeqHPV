#'

scaling_of_b2m_human_control <- function(read_metrics_df, run_manifest_path, scaling_table, pos_neg_filtering_criteria_path){

#1.  sum the pass filter reads for entire chip (all BC's); "qualified_aligned_reads" from read_metrics table output

sum_pass_filter_reads = sum(read_metrics_df$qualified_aligned_reads)

#2.  count number of samples in each run using the manifest (count rows I guess)

temp = read_csv(run_manifest_path) %>%
mutate(sample_num = n())

number_of_samples = temp$sample_num[1]

number_of_samples

#3.  calculate average number of qualified reads per sample

mean_qualified_reads = sum_pass_filter_reads / number_of_samples
mean_qualified_reads

#4.  Set B2M min (inclusive) read numbers to min in factoring table

factoring_table = read_csv(scaling_table) %>%
filter(min_avg_reads_boundary <= mean_qualified_reads & max_avg_reads_boundary >= mean_qualified_reads) %>%
glimpse()

#5.  apply factor based on scaling table to the min HPV total and type reads

filtering_criteria = read_tsv(pos_neg_filtering_criteria_path) %>%
map_if(is.factor, as.character) %>%
as_tibble() %>%
rename(type_id = TYPE) %>%
mutate(factored_min_reads_per_type = factoring_table$HPV_scaling_factor * Min_reads_per_type) %>%
glimpse()
  
  
temp = list(factoring_table = factoring_table, filtering_criteria = filtering_criteria)  
  
return(temp)  
}
