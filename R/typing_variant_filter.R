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
    filter(!(is.na(Owner_Sample_ID))) %>% 
    mutate(barcode = paste0(BC1, BC2)) %>% 
    full_join(variants) 
    
  
  variants_with_zero = variants_with_all %>%  #Modify the DP from NA to '0'
    select(-filename, -BC1, -BC2) %>%
    filter(is.na(HS)) %>% 
    mutate(DP = 0) %>%
    mutate(CHROM = "HPV_fake")
 
  #This step is to ensure the samples with no variant calls are retained in the matrix 
  if(length(variants_with_zero$barcode)>0) {
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
  } else{
    variants_with_manifest = variants_with_all %>%
      select(-filename, -BC1, -BC2) %>%
      filter(HS)
    # make read_counts_matrix ---- 
    read_counts_matrix_long = variants_with_manifest %>%
      group_by(Owner_Sample_ID, barcode, CHROM) %>%
      summarize(depth = max(DP)) %>%
      group_by(barcode) %>%
      mutate(total_reads = sum(depth)) %>%
      group_by(barcode, Owner_Sample_ID)%>%
      spread(CHROM,depth, fill = '0') %>%
      gather(CHROM,depth,-total_reads,-Owner_Sample_ID,-barcode)
  }
  
  
  
  read_counts_matrix_wide = read_counts_matrix_long %>%
    spread(CHROM, depth) %>%
    filter(!is.na(Owner_Sample_ID))
  
  read_count_matrix_report = read_counts_matrix_wide %>%
    gather(HPV_Type, HPV_Type_count, -barcode,-total_reads, -Owner_Sample_ID,-`ASIC-Low`,-`ASIC-High`,-`ASIC-Med`,-`ESIC-High`,-`ESIC-Low`,-`ESIC-Med`,-`B2M-L`,-`B2M-S`) %>%
    write.csv("read_count_matrix_report")

  
  
  #Rearranging column names to match the order of contigs in variant file. 
  read_counts_matrix_wide_final = manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    full_join(read_counts_matrix_wide[,str_sort(colnames(read_counts_matrix_wide), numeric = T)] %>%
              select(barcode,Owner_Sample_ID,total_reads,`ASIC-Low`, `ASIC-Med`, `ASIC-High`, `B2M-L`, `B2M-S`,everything())) %>%
    select(-BC1, -BC2) %>%
    filter(!is.na(Owner_Sample_ID))
  
  
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

  write.csv(pn_filters,"pn_filters_report")

  
  # make detailed pn matrix ----
  read_counts_matrix_long %>%
    inner_join(pn_filters) %>% 
    transform(depth = as.integer(depth)) %>%
    mutate(status = ifelse(depth >= Min_reads_per_type, "pos", "neg")) %>%
    glimpse() %>%
    select(-depth) %>%
    select(-total_reads,-Min_reads_per_type) %>%
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
  
  #Override step
  new %>%  
    tidyr::gather("type_id", "type_status", starts_with("HPV")) %>%
    group_by(barcode) %>% 
    mutate(type_status = ifelse(human_control == "failed_to_amplify","neg",type_status)) %>%
    spread(type_id,type_status) -> new
  
  
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
    rename("ASIC_High"=ASICHigh, "ASIC_Low"=ASICLow, "ASIC_Med"=ASICMed, "ESIC_High"=ESICHigh,"ESIC_Low"=ESICLow,"ESIC_Med"=ESICMed, "B2M_L"=B2ML, "B2M_S"=B2MS)  %>%
    filter(!is.na(Owner_Sample_ID))-> detailed_pn_matrix
    
  detailed_pn_matrix = detailed_pn_matrix[,str_sort(colnames(detailed_pn_matrix), numeric = T)] %>%
    select(barcode,Num_Types_Pos,Owner_Sample_ID, ASIC_Low, ASIC_Med, ASIC_High, Assay_SIC, B2M_L, B2M_S,human_control,everything())
    write.csv(detailed_pn_matrix,"detailed_pn_matrix_report")
  
  #  print("line 110")
  
  deatiled_pn_matrix_for_report1 = manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    inner_join(detailed_pn_matrix) %>%
    select(-BC1, -BC2) %>%
    select(-starts_with("HPV"), everything(), starts_with("HPV"))
    
  
 # str_replace_all(colnames(r),"-","_") -> colnames(temp_detailed_pn_matrix)
  
  
  # make simple pn matrix ----
  
  simple_pn_matrix_long = detailed_pn_matrix %>%
    filter(!is.na(Owner_Sample_ID)) %>%
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
  
  #Creating positive-negative matrix
  simple_pn_matrix_final = manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    inner_join(simple_pn_matrix[,str_sort(colnames(simple_pn_matrix), numeric = T)] %>%
                 select(barcode,Num_Types_Pos,Owner_Sample_ID, ASIC_Low, ASIC_Med, ASIC_High, Assay_SIC, B2M_L, B2M_S,human_control,everything())) %>%
    select(-BC1, -BC2)  %>%
    filter(!is.na(Owner_Sample_ID))
  
  write.csv(simple_pn_matrix_final,"pn_matrix_for_groupings")
    

  print("line 148")
  
  #Changing the '.' to '_' to makesure it doesn't cause format issues downstream
   specimen_control_defs%>%
    rename("B2M_S"=`B2M-S`, "B2M_L"=`B2M-L`) -> specimen_control_defs 
  
  specimen_control_defs_long = specimen_control_defs %>%
    filter(!is.na(Control_Code)) %>%
    tidyr::gather("type", "status", -Control_Code, -qc_name,-Control_type, factor_key = TRUE) %>%
    glimpse()
  
  #Creating a list of failed samples
  simple_pn_matrix %>%
    filter(human_control == "failed_to_amplify") %>%
    full_join(specimen_control_defs %>% select(Control_Code,Control_type), by = c("Owner_Sample_ID"= "Control_Code")) %>%
    filter(is.na(Control_type)) %>%
    inner_join(manifest %>% mutate(barcode = paste0(BC1, BC2)), by = c("barcode","Owner_Sample_ID")) -> failed_pn_matrix
    
  failed_pn_matrix_final = manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    inner_join(failed_pn_matrix[,str_sort(colnames(simple_pn_matrix), numeric = T)] %>%
                 select(barcode,Num_Types_Pos,Owner_Sample_ID, ASIC_Low, ASIC_Med, ASIC_High, Assay_SIC, B2M_L, B2M_S,human_control,everything())) %>%
    select(-BC1, -BC2) %>%
    filter(!is.na(Owner_Sample_ID))
  
  
  
  # 2.  merge pn matrix with control defs
  
  print("line 158")
  
  control_results_final<- simple_pn_matrix %>%
    select(-human_control,-Ext_SIC,-Assay_SIC, -Num_Types_Pos) %>%
    gather(type,status, -barcode,-Owner_Sample_ID,-ESIC_High,-ESIC_Low,-ESIC_Med,-ASIC_Low,-ASIC_High,-ASIC_Med) %>%
    inner_join(specimen_control_defs_long %>% mutate(Owner_Sample_ID = Control_Code), by = c("Owner_Sample_ID", "type")) %>%  
  #  inner_join(specimen_control_defs %>% select(-B2M.S,-B2M.L)) %>%
    mutate(status_count = ifelse(status.x == status.y, 0, 1)) %>%
    group_by(barcode) %>%
    mutate(sum_status_count = sum(status_count)) %>%
    mutate(control_result = ifelse(sum_status_count == 0, "pass","fail")) %>%
    select(barcode,Owner_Sample_ID,Control_Code,control_result,type, status.x,ESIC_High,ESIC_Low,ESIC_Med,ASIC_Low,ASIC_High,ASIC_Med) %>% 
    distinct() %>%
    spread(type,status.x) %>% 
    inner_join(read_counts_matrix_wide %>% select(barcode,Owner_Sample_ID,total_reads), by = c("barcode","Owner_Sample_ID")) 
  
  #Adding manifest to the final results 
   control_results_final = manifest %>% 
    mutate(barcode = paste0(BC1,BC2)) %>%
    inner_join(control_results_final[,str_sort(colnames(control_results_final), numeric = T)] %>%
     select(barcode,total_reads,Owner_Sample_ID,ASIC_Low, ASIC_Med, ASIC_High, B2M_L, B2M_S,everything()) )  %>%
     filter(!is.na(Owner_Sample_ID))
    
  
  control_for_report = control_results_final %>%
    inner_join(manifest) 
    write.csv(control_for_report,"control_for_report")
  
  
  print("line 188")
  
  #samples_only_pn_matrix = simple_pn_matrix[!(simple_pn_matrix$barcode %in% control_results_final$barcode),]
  
  samples_only_pn_matrix = simple_pn_matrix %>%
    left_join(select(control_results_final, barcode, Control_Code)) %>%
    filter(is.na(Control_Code)) %>%
    glimpse()
  
  samples_only_pn_matrix_final = manifest %>%
    mutate(barcode = paste0(BC1,BC2)) %>%
    inner_join(samples_only_pn_matrix[,str_sort(colnames(samples_only_pn_matrix), numeric = T)] %>%
    select(barcode,Owner_Sample_ID, ASIC_Low, ASIC_Med, ASIC_High, B2M_L, B2M_S,everything())) %>% 
    select(-Control_Code) %>%
    filter(!is.na(Owner_Sample_ID))
    
  
  samples_only_for_report = samples_only_pn_matrix %>%
    inner_join(manifest %>% mutate(barcode = paste0(BC1,BC2))) %>%
    inner_join(read_counts_matrix_wide %>% select(barcode, Owner_Sample_ID, total_reads)) %>%
    filter(!is.na(Project)) 
    write_csv(samples_only_for_report,"samples_only_for_report")
  
  
  #failed_samples_only_pn_matrix = samples_only_pn_matrix %>%
   # filter(str_detect(human_control, fixed("fail", ignore_case = TRUE))) %>%
  #  glimpse() 
   # write_csv(failed_samples_only_pn_matrix,"failed_samples_matrix_results.csv")
  
  
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

  #Classifying as pass or fail based on set filters
  
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
  
  
  # calculate AF with only the ones which passed the filters in the last step 
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
    select(-key)  
    
    
  #Join manifest to add all the information
    lineage_final = manifest %>% 
    mutate(barcode = paste0(BC1,BC2)) %>%
    select(-BC1,-BC2) %>%
    inner_join(lineage_for_report[,str_sort(colnames(lineage_for_report), numeric = T)]) %>%
    filter(!is.na(Owner_Sample_ID))
    
    write.csv(lineage_final, "lineage_for_report")

# Adding Assay code to all result files

#Get the assay code

man = manifest %>% transform(Assay_Batch_Code = as.factor(Assay_Batch_Code),Project = as.factor(Project))   
code = levels(unique(man$Assay_Batch_Code))
Project_code = levels(unique(man$Project))
    
for (i in Project_code){
  
  samples_only_pn_matrix_final %>%
    filter(!is.na(Owner_Sample_ID)) %>%
    filter(Project == i) %>%
    write_csv(paste0(i,"_","samples_only_matrix_results.csv"))
  
}    

    
    
for (i in code){
      print(i)
      write.csv(read_counts_matrix_wide_final ,file = paste0(i,"-","read_counts_matrix_results.csv"), row.names = F)
      write.csv(pn_filters,file = paste0(i,"-","pn_filters_report"), row.names = F)
      write.csv(deatiled_pn_matrix_for_report1, paste0(i,"-","detailed_pn_matrix_results.csv"), row.names = F)
      write.csv(simple_pn_matrix_final,paste0(i,"-","pn_matrix_results.csv"), row.names = F)
      write.csv(failed_pn_matrix_final,paste0(i,"-","failed_samples_pn_matrix_results.csv"), row.names = F)
      write.csv(control_results_final, paste0(i,"-","control_results.csv"), row.names = F)
      write.csv(lineage_final,paste0(i,"-","lineage_filtered_results.csv"), row.names = F)
      
      }
   
      
}

