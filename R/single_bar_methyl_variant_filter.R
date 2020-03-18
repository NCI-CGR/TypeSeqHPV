single_bar_methyl_variant_filter <- function(variants, filteringTablePath, posConversionTable, manifest, control_defs){
  
  require(fuzzyjoin)
  
  manifest %>%
  transform(BC1 = as.character(BC1)) %>% 
    rename(barcode = BC1) -> manifest
  
  
  filteringTable = read_tsv(filteringTablePath) %>%
    map_if(is.factor, as.character) %>%
    as_tibble() %>%
    rename(CHROM = Chr, POS = Base_num, REF = Base_ID, ALT = vcf_variant)
  
  #hotspot vars...
  
  GA_variants = variants %>%
    filter(HS) %>%
    filter(!(ALT %in% c("C", "T"))) %>%
    glimpse()
  
  manifest %>%
    inner_join(GA_variants) %>%
    select(-filename) %>%
    filter(!(is.na(Owner_Sample_ID))) %>%
    write_csv("lineage_variants_results.csv")
  
  pos_conversion = read_tsv(posConversionTable) %>%
    map_if(is.factor, as.character) %>%
    as_tibble()
  
  filtered_variants = variants %>%
    filter(ALT %in% c("C", "T")) %>%
    inner_join(filteringTable) %>%
    mutate(AF = as.double(AF)) %>%
    mutate(methyl_freq = case_when(
      ALT == "C" ~ AF,
      ALT == "T" ~ 1 - AF)) %>%
    mutate(qc_reason = "Pass") %>%
    mutate(qc_reason = ifelse(DP >= min_DP, qc_reason,
                              "min_DP")) %>%
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
    mutate(qc_reason = ifelse(methyl_freq >= min_freq, qc_reason,
                              paste0(qc_reason, ";", "min_freq"))) %>%
    mutate(qc_reason = ifelse(methyl_freq <= max_freq, qc_reason,
                              paste0(qc_reason, ";", "max_freq"))) %>%
    mutate(qc_reason = ifelse(FILTER == "PASS", qc_reason,
                              paste0(qc_reason, ";", FILTER))) %>%
    mutate(status = ifelse(qc_reason == "Pass", "Pass", "Fail")) %>%
    rename(pos_amplicon = POS, chr_amplicon = CHROM) %>%
    glimpse() %>%
    inner_join(pos_conversion) %>%
    select(chr, pos, DP, methyl_freq, QUAL, status, qc_reason, everything())
  
  return_table = manifest %>%
    left_join(filtered_variants) %>%
    filter(!(is.na(Owner_Sample_ID))) %>%
    write_csv("target_variants_results.csv")
  
  coverage_matrix = return_table %>%
    group_by(Owner_Sample_ID, barcode, chr_amplicon) %>%
    summarize(depth = max(DP)) %>%
    ungroup() %>%
    group_by(barcode, Owner_Sample_ID) %>%
    spread(chr_amplicon, depth) %>%
    glimpse() 
  
  manifest %>%
    inner_join(coverage_matrix) %>%
    filter(!(is.na(Owner_Sample_ID))) %>%
    write_csv("coverage_matrix_results.csv") 
  
  #freq_matrix
  
  freq_matrix = return_table %>%
    group_by(Owner_Sample_ID, barcode, chr_amplicon) %>%
    summarize(mean_freq = mean(methyl_freq)) %>%
    ungroup() %>%
    group_by(barcode, Owner_Sample_ID) %>%
    spread(chr_amplicon, mean_freq) %>%
    glimpse() 
  
  manifest %>%
    inner_join(freq_matrix) %>%
    filter(!(is.na(Owner_Sample_ID))) %>%
    write_csv("freq_matrix_results.csv") 
  
  control_defs = control_defs %>%
    glimpse() %>%
    tidyr::gather("chrom", "min_coverage", -control_code) %>%
    glimpse()
  
  control_results = coverage_matrix %>%
    gather("chrom", "depth", -Owner_Sample_ID, -barcode) %>%
    mutate(depth = as.integer(depth)) %>%
    fuzzy_join(control_defs, mode = "inner", by = c("Owner_Sample_ID" = "control_code"), match_fun = function(x, y) str_detect(x, fixed(y, ignore_case = TRUE))) %>%
    filter(chrom.x == chrom.y) %>%
    mutate(control_result = ifelse(depth >= min_coverage, "pass", "fail")) %>%
    glimpse() %>%
    select(Owner_Sample_ID, barcode, chrom = chrom.x, control_result) %>%
    arrange(Owner_Sample_ID, chrom) %>%
    spread(chrom, control_result) 
  
  manifest %>%
    inner_join(control_results) %>%
    filter(!(is.na(Owner_Sample_ID))) %>%
    write_csv("control_results.csv")
  
  
  #non-hotspot vars...
  non_hotspot_vars = variants %>%
    filter(!HS)
  
  manifest %>%
    inner_join(non_hotspot_vars) %>%
    filter(!(is.na(Owner_Sample_ID))) %>%
    write_csv("non_target_variants_results.csv")
  
  return(return_table)
  
  
}