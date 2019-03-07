#+
vcf_to_dataframe <- function(vcf_files){
    require(tidyverse)
    require(fs)
    require(vcfR)

    temp = read.vcfR(vcf_files$vcf_out)

    temp = vcfR2tidy(temp)

    temp = temp$fix %>%
    as_tibble() %>%
    mutate(filename = vcf_files$vcf_out) %>%
    select(filename, everything())

    return(temp)


}

methyl_variant_filter <- function(variants, filteringTablePath, posConversionTable){

filteringTable = read_tsv(filteringTablePath) %>% 
  map_if(is.factor, as.character) %>% 
  as_tibble() %>% 
  rename(CHROM = Chr, POS = Base_num, REF = Base_ID, ALT = vcf_variant)

GA_variants = variants %>% 
  filter(!(ALT %in% c("C", "T"))) %>% 
  glimpse() 

manifest %>%
    mutate(barcode = paste0(BC1, BC2)) %>%
    left_join(GA_variants) %>%
    select(-filename, -BC1, -BC2) %>% 
    write_csv("lineage_variants.csv")

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
    mutate(barcode = paste0(BC1, BC2)) %>%
    left_join(filterd_variants) %>%
    select(-filename, -BC1, -BC2) %>% 
    write_csv("variant_table.csv")
 
 return_table = filtered_variants
 
 coverage_matrix = return_table %>% 
  group_by(Owner_Sample_ID, barcode, chr_amplicon) %>% 
  summarize(depth = max(DP)) %>% 
  ungroup() %>% 
  group_by(barcode, Owner_Sample_ID) %>% 
  spread(chr_amplicon, depth) %>% 
  glimpse() %>%
  write_csv("coverage_matrix.csv")
 
 freq_matrix = return_table %>% 
  group_by(Owner_Sample_ID, barcode, chr_amplicon) %>% 
  summarize(mean_freq = mean(methyl_freq)) %>% 
  ungroup() %>% 
  group_by(barcode, Owner_Sample_ID) %>% 
  spread(chr_amplicon, mean_freq) %>% 
  glimpse() %>%
  write_csv("freq_matrix.csv")
 
}
