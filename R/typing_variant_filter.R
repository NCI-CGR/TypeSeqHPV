#+

typing_variant_filter <- function(variants, lineage_defs, manifest,
                                  specimen_control_defs, internal_control_defs,
                                  pn_filters, scaling_table){
  
  require(fuzzyjoin)
  ##test
  
  coalesce_all_columns <- function(df) {
    return(coalesce(!!! as.list(df))) }
  
  # add manifest to variants table ----
  variants_with_all = manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>% 
    full_join(variants) 
  
  variants_with_zero = variants_with_all %>%  #Modify the DP from NA to '0'
    select(-filename, -BC1, -BC2) %>%
    filter(is.na(HS)) %>% 
    mutate(DP = 0) %>%
    mutate(CHROM = "HPV_fake")
  
  variants_with_manifest = variants_with_all %>%
    select(-filename, -BC1, -BC2) %>%
    filter(HS) %>%   #This is filtering the variants which are hotspots
    full_join(variants_with_zero)
  
  # make read_counts_matrix ----
  
  read_counts_matrix_long = variants_with_manifest %>%
    group_by(Owner_Sample_ID, barcode, CHROM) %>%
    summarize(depth = max(DP)) %>%
    group_by(barcode) %>%
    mutate(total_reads = sum(depth)) %>%
    group_by(barcode, Owner_Sample_ID)%>%
    spread(CHROM,depth, fill = '0') %>%
    select(-HPV_fake) %>%
    gather(CHROM,depth,-total_reads,-Owner_Sample_ID,-barcode)
  
  
  read_counts_matrix_wide = read_counts_matrix_long %>%
    spread(CHROM, depth)
  
  read_counts_matrix_wide = manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    left_join(read_counts_matrix_wide) %>%
    select(-BC1, -BC2) 
  
  #Rearranging column names to match the order of contigs in variant file. 
  read_counts_matrix_wide = read_counts_matrix_wide[,str_sort(colnames(read_counts_matrix_wide), numeric = T)] %>%
    select(barcode,Owner_Sample_ID, `ASIC-Low`, `ASIC-Med`, `ASIC-High`, `B2M-L`, `B2M-S`,everything()) %>%
    write_csv("read_counts_matrix_results.csv")
  
  
  print("line 41")
  
  # scale the filters - calculate the average reads per sample ----
  
  average_total_reads_df = read_counts_matrix_long %>%
    ungroup() %>%
    summarize(average_read_count = mean(total_reads))
  
  scaling_df = read.csv(scaling_table) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    glimpse() %>%
    mutate(average_read_count = average_total_reads_df$average_read_count) %>%
    filter(min_avg_reads_boundary <= average_read_count & max_avg_reads_boundary >= average_read_count) %>%
    glimpse()
  
  scaling_factor = scaling_df$scaling_factor
  
  print("line 56")
  
  # read in internal controls ----
  internal_control_defs = read.csv(internal_control_defs) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    glimpse()
  
  # read in pn_filters ----
  
  pn_filters = read.csv(pn_filters) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    glimpse() %>%
    rename(CHROM = contig) %>%
    mutate(Min_reads_per_type = Min_reads_per_type * scaling_factor)
 
 
  
  # make detailed pn matrix ----
  read_counts_matrix_long %>%
    inner_join(pn_filters) %>% 
    mutate(status = ifelse(depth >= Min_reads_per_type, "pos", "neg")) %>%
    glimpse() %>%
    select(-depth) %>%
    select(-total_reads,-Owner_Sample_ID,-Min_reads_per_type) %>%
    spread(CHROM, status) ->new
  
 
  str_replace_all(colnames(new),"[-]", "")-> colnames(new)
  
  internal_control_defs<-as.data.frame(internal_control_defs)
  str_replace_all(names(internal_control_defs),"[.]", "")->colnames(internal_control_defs)
  internal_control_defs %>%
    group_by(qc_name) %>%
    summarize() -> get_list
  
  get_list<-as.list(get_list$qc_name)
 
   for (i in get_list) {
    assign(paste0("output",i),internal_control_defs[internal_control_defs$qc_name == i,])
  }
  
  new %>%
    left_join(outputAssay_SIC, by = c("ASICHigh","ASICLow","ASICMed")) %>%
    select(barcode,ASICHigh,ASICLow,ASICMed,internal_control_code, qc_name, qc_print) %>%
    spread(qc_name, qc_print) %>%
    select(-internal_control_code) %>%
    full_join(new) -> new
  new %>%
    left_join(outputExt_SIC, by = c("ESICHigh","ESICLow","ESICMed")) %>%
    select(barcode,ESICHigh,ESICLow,ESICMed,internal_control_code, qc_name, qc_print) %>%
    spread(qc_name, qc_print) %>%
    select(-internal_control_code) %>%
    full_join(new) -> new
  new %>%
    left_join(outputhuman_control, by = c("B2ML", "B2MS")) %>%
    select(barcode,B2ML,B2MS,internal_control_code, qc_name, qc_print) %>%
    spread(qc_name, qc_print) %>%
    select(-internal_control_code) %>%
    full_join(new) -> new
  
  new %>%  
    tidyr::gather("type_id", "type_status", starts_with("HPV")) %>%
    group_by(barcode) %>%
    mutate(Num_Types_Pos = if_else(type_status == "pos", 1, 0)) %>%
    mutate(type2 = type_id) %>%
    mutate(type_id = gsub("_.*","",type_id)) -> new2
  
  
  new2 %>%
    select(barcode,type_id,Num_Types_Pos) %>%
    unique() %>%
    mutate(Num_Types_Pos = sum(Num_Types_Pos)) %>%
    select(-type_id) %>%
    unique() -> table_with_final_count
  
    final<-merge(new,table_with_final_count, by = "barcode")
    
    final %>%
    rename("ASIC_High"=ASICHigh, "ASIC_Low"=ASICLow, "ASIC_Med"=ASICMed, "ESIC_High"=ESICHigh,"ESIC_Low"=ESICLow,"ESIC_Med"=ESICMed, "B2M_L"=B2ML, "B2M_S"=B2MS)-> detailed_pn_matrix
    
  detailed_pn_matrix = detailed_pn_matrix[,str_sort(colnames(detailed_pn_matrix), numeric = T)] %>%
      select(barcode,Owner_Sample_ID, ASIC_Low, ASIC_Med, ASIC_High, Assay_SIC, B2M_L, B2M_S,human_control,everything())
  
  #  print("line 110")
  
  detatiled_pn_matrix_for_report = manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    inner_join(detailed_pn_matrix) %>%
    select(-BC1, -BC2) %>%
    select(-starts_with("HPV"), everything(), starts_with("HPV")) %>%
    write_csv("detailed_pn_matrix_results.csv")
  
  detailed_pn_matrix_for_report = detatiled_pn_matrix_for_report %>%
    select(barcode, Owner_Sample_ID, Num_Types_Pos, human_control) %>%
    inner_join(read_counts_matrix_wide ,by = c("barcode","Owner_Sample_ID")) 
  
 # str_replace_all(colnames(r),"-","_") -> colnames(temp_detailed_pn_matrix)
  
  
  # make simple pn matrix ----
  
  simple_pn_matrix_long = detailed_pn_matrix %>%
    gather("CHROM", "status", starts_with("HPV"), factor_key = TRUE) %>%
    separate(CHROM, sep = "_", into = c("type"), remove = FALSE, extra = "drop") %>%
    glimpse() %>%
    mutate(status_as_integer = ifelse(status == "pos", 1, 0)) %>%
    group_by(barcode, type) %>%
    mutate(sum_status = sum(status_as_integer)) %>%
    mutate(simple_status = ifelse(sum_status >= 1, "pos", "neg")) %>%
    ungroup() %>%
    glimpse() %>%
    select(-status_as_integer, -CHROM, -sum_status, -status) %>%
    distinct() %>%
    glimpse() %>%
    group_by(barcode, type) %>%
    distinct() 
  
  simple_pn_matrix = simple_pn_matrix_long %>%
    spread(type, simple_status) %>%
    glimpse()
  
  simple_pn_matrix_final = manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    inner_join(simple_pn_matrix) %>%
    select(-BC1, -BC2) %>%
    write_csv("pn_matrix_results.csv")
  
  print("line 148")
  
  # specimen_control_defs%>%
  #  rename("B2M_S"=B2M.S, "B2M_L"=B2M.L) -> specimen_control_defs 
  
  specimen_control_defs_long = specimen_control_defs %>%
    filter(!is.na(Control_Code)) %>%
    tidyr::gather("type", "status", -Control_Code, -qc_name, factor_key = TRUE) %>%
    glimpse()
  
  # 2.  merge pn matrix with control defs
  
  print("line 158")
  
  control_results_final<- simple_pn_matrix %>%
    select(-human_control,-ESIC_High,-ESIC_Low,-Ext_SIC,-ASIC_Low,-ASIC_High,-ASIC_Med,-Assay_SIC, -Num_Types_Pos) %>%
    gather(type,status, -barcode,-Owner_Sample_ID) %>%
    inner_join(specimen_control_defs_long, by = c("Owner_Sample_ID" = "Control_Code", "type")) %>%
    full_join(specimen_control_defs) %>%
    mutate(status_count = ifelse(status.x == status.y, 0, 1)) %>%
    group_by(barcode) %>%
    mutate(sum_status_count = sum(status_count)) %>%
    mutate(control_result = ifelse(sum_status_count == 0, "pass","fail")) %>%
    select(barcode,Owner_Sample_ID,Control_Code,control_result,type, status.x) %>% 
    distinct() %>%
    spread(type,status.x) %>%
    write_csv("control_results.csv")
  
  control_for_report = control_results_final %>%
    inner_join(manifest)
  
  
  print("line 188")
  
  #samples_only_pn_matrix = simple_pn_matrix[!(simple_pn_matrix$barcode %in% control_results_final$barcode),]
  
  samples_only_pn_matrix = simple_pn_matrix %>%
    left_join(select(control_results_final, barcode, Control_Code)) %>%
    filter(is.na(Control_Code)) %>%
    glimpse() %>%
    write_csv("samples_only_matrix_results.csv")
  
  samples_only_for_report = samples_only_pn_matrix %>%
    inner_join(manifest) %>%
    write_csv("samples_only_for_report")
  
  failed_samples_only_pn_matrix = samples_only_pn_matrix %>%
    filter(str_detect(human_control, fixed("fail", ignore_case = TRUE))) %>%
    glimpse() %>%
    write_csv("failed_samples_matrix_results.csv")
  
  
  # # identify lineages ----
  lineage_defs = read.csv(lineage_defs) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    rename(CHROM = Chr, POS = Base_num, REF = Base_ID, ALT = vcf_variant) %>%
    mutate(reg_count = 1) %>%
    group_by(Lineage_ID) %>%
    mutate(def_count = sum(reg_count))
  
  # Counting the lineages per type here. Later this can be used to check if a sample has all the lineages.
  
  
  lineage_filtered_initial = variants %>%
    inner_join(lineage_defs, by=c('CHROM','POS','REF','ALT')) %>% 
    filter(!is.na(barcode)) %>% 
    mutate(new_res = 1) %>%
    group_by(barcode, Lineage_ID) %>% # Grouping by barcode and lineages to then sum the lineages per sample.
   # mutate(new_res = sum(new_res)) %>%
    ungroup() 

  
  lineage_filtered = lineage_filtered_initial %>%  
    mutate(AF = as.double(AF)) %>%
    mutate(qc_reason = "") %>%
    mutate(qc_reason = ifelse(SRF >= min_coverage_pos, qc_reason,
                              paste0(qc_reason, ";", "min_coverage_pos"))) %>%
    mutate(qc_reason = ifelse(SRR >= min_coverage_neg, qc_reason,
                              paste0(qc_reason, ";", "min_coverage_neg"))) %>%
    mutate(qc_reason = ifelse(SAF >= min_allele_coverage_pos, qc_reason,
                              paste0(qc_reason, ";", "min_allele_coverage_pos"))) %>%
    mutate(qc_reason = ifelse(SAR >= min_allele_coverage_neg, qc_reason,
                              paste0(qc_reason, ";", "min_allele_coverage_neg"))) %>%
    mutate(qc_reason = ifelse(QUAL >= min_qual, qc_reason,
                              paste0(qc_reason, ";", "min_qual"))) %>%
    mutate(qc_reason = ifelse(STB <= max_alt_strand_bias, qc_reason,
                              paste0(qc_reason, ";", "max_alt_strand_bias"))) %>%
    mutate(qc_reason = ifelse(AF >= min_freq, qc_reason,
                              paste0(qc_reason, ";", "min_freq"))) %>%
    mutate(qc_reason = ifelse(AF <= max_freq, qc_reason,
                              paste0(qc_reason, ";", "max_freq"))) %>%
    mutate(qc_reason = ifelse(FILTER == "PASS", qc_reason,
                              paste0(qc_reason, ";", FILTER))) %>%
    # mutate(new_qc_reason = ifelse(SRF >= min_coverage_pos & SRR >= min_coverage_neg & SAF >= min_allele_coverage_pos & SAR >= min_allele_coverage_neg & QUAL >= min_qual & STB <= max_alt_strand_bias &
    #                                AF >= min_freq & AF <= max_freq & FILTER == "PASS", 0, 1)) %>%
    mutate(qc_reason = ifelse(qc_reason == "", "Pass", qc_reason)) %>% 
    mutate(AF = ifelse(qc_reason == "Pass",AF,0)) %>%
    mutate(new_res = ifelse(qc_reason == "Pass", new_res,0)) %>%
    group_by(barcode,Lineage_ID) %>%
    mutate(new_res = sum(new_res)) %>%
    mutate(lineage_status = ifelse(qc_reason == "Pass" & new_res == def_count, 1, 0)) -> lineage_all 
  
  
  # calculate AF with only the ones which passed  
  lineage_all %>%
    filter(lineage_status == 1) %>%
    group_by(barcode, Lineage_ID) %>% 
    mutate(lineage_status_sum = sum(lineage_status)) %>% 
    mutate(AF_sum = sum(AF)) %>%
    mutate(AF = AF_sum/lineage_status_sum) %>% 
    ungroup() %>% 
    select(barcode, CHROM, POS, REF, ALT, Lineage_ID, AF)-> lineage_filtered_pass

  
  #Join the passed table to original table 
  
  lineage_for_report = lineage_all %>%
    select(barcode,CHROM,POS,REF,ALT,Lineage_ID) %>% 
    full_join(lineage_filtered_pass) %>% 
    mutate(AF = ifelse(is.na(AF),0,AF)) %>% 
    select(-CHROM, -POS, -REF,-ALT) %>%
    distinct() %>% 
    group_by(barcode, Lineage_ID) %>%
    mutate(key = row_number()) %>% 
    mutate(AF = AF*100) %>%
    spread(Lineage_ID,AF) %>%
    select(-key) %>% 
    write_csv("lineage_filtered_results.csv")
  
  
  
  
}

