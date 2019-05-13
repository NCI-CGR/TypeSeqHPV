#+

typing_variant_filter <- function(variants, lineage_defs, manifest,
                                  specimen_control_defs, internal_control_defs,
                                  pn_filters, scaling_table){

    require(fuzzyjoin)

    coalesce_all_columns <- function(df) {
        return(coalesce(!!! as.list(df))) }

    # add manifest to variants table ----

    variants_with_manifest = manifest %>%
        mutate(barcode = paste0(BC1, BC2)) %>%
        inner_join(variants) %>%
        select(-filename, -BC1, -BC2) %>%
        filter(HS) %>%
        glimpse()

    # make read_counts_matrix ----

    read_counts_matrix_long = variants_with_manifest %>%
        group_by(Owner_Sample_ID, barcode, CHROM) %>%
        summarize(depth = max(DP)) %>%
        group_by(barcode) %>%
        mutate(total_reads = sum(depth)) %>%
        group_by(barcode, Owner_Sample_ID)


    read_counts_matrix_wide = read_counts_matrix_long %>%
        spread(CHROM, depth)

    read_counts_matrix_wide = manifest %>%
        mutate(barcode = paste0(BC1, BC2)) %>%
        inner_join(read_counts_matrix_wide) %>%
        select(-BC1, -BC2) %>%
        write_csv("read_counts_matrix_results.csv")


  print("line 41")

    # scale the filters - calculate the average reads per sample ----

    average_total_reads_df = read_counts_matrix_long %>%
        ungroup() %>%
        summarize(average_read_count = mean(total_reads))

    scaling_df = read_csv(scaling_table) %>%
        map_if(is.factor, as.character) %>%
        as_tibble() %>%
        glimpse() %>%
        mutate(average_read_count = average_total_reads_df$average_read_count) %>%
        filter(min_avg_reads_boundary <= average_read_count & max_avg_reads_boundary >= average_read_count) %>%
        glimpse()

    scaling_factor = scaling_df$scaling_factor

  print("line 56")

    # read in internal controls ----
    internal_control_defs = read_csv(internal_control_defs) %>%
        map_if(is.factor, as.character) %>%
        as_tibble() %>%
        tidyr::gather("CHROM", "control_status", -internal_control_code, -qc_name, -qc_print, factor_key = TRUE) %>%
        filter(!(is.na(control_status))) %>%
        glimpse()

    # read in pn_filters ----

    pn_filters = read_csv(pn_filters) %>%
        map_if(is.factor, as.character) %>%
        as_tibble() %>%
        glimpse() %>%
        rename(CHROM = contig) %>%
        mutate(Min_reads_per_type = Min_reads_per_type * scaling_factor)

    # make detailed pn matrix ----

    detailed_pn_matrix = read_counts_matrix_long %>%
        inner_join(pn_filters) %>%
        mutate(status = ifelse(depth >= Min_reads_per_type, "pos", "neg")) %>%
        glimpse() %>%
        select(-depth) %>%
        left_join(internal_control_defs) %>%
        mutate(control_status_as_num = ifelse(status == control_status,
                                                  0, 1)) %>%
        group_by(barcode, CHROM) %>%
        mutate(sum_control_status_as_num = sum(control_status_as_num)) %>%
        mutate(qc_print = ifelse(sum_control_status_as_num == 0, qc_print, "Fail")) %>%
        ungroup() %>%
        select(Owner_Sample_ID, barcode, CHROM, status, qc_name, qc_print) %>%
        distinct() %>%

        spread(CHROM, status) %>%
        mutate(num = 1:n()) %>%
        spread(qc_name, qc_print) %>%
        distinct() %>%
        group_by(barcode) %>%
        select(-num) %>%
        summarise_all(coalesce_all_columns) %>%
        select(-`<NA>`) %>%
        ungroup() %>%
        tidyr::gather("type_id", "type_status", starts_with("HPV"), factor_key = TRUE) %>%
        group_by(barcode) %>%
        mutate(Num_Types_Pos = if_else(type_status == "pos", 1, 0)) %>%
        mutate(Num_Types_Pos = sum(Num_Types_Pos)) %>%
        spread(type_id, type_status)

  print("line 110")

       manifest %>%
        mutate(barcode = paste0(BC1, BC2)) %>%
        inner_join(detailed_pn_matrix) %>%
        select(-BC1, -BC2) %>%
        select(-starts_with("HPV"), everything(), starts_with("HPV")) %>%
        write_csv("detailed_pn_matrix_results.csv")


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

    simple_pn_matrix = manifest %>%
        mutate(barcode = paste0(BC1, BC2)) %>%
        inner_join(simple_pn_matrix) %>%
        select(-BC1, -BC2) %>%
        write_csv("pn_matrix_results.csv")

  print("line 148")


    specimen_control_defs_long = specimen_control_defs %>%
        filter(!is.na(Control_Code)) %>%
        tidyr::gather("type", "status", -Control_Code, -qc_name, factor_key = TRUE) %>%
        glimpse()

        # 2.  merge pn matrix with control defs

  print("line 158")

        control_results_pre = simple_pn_matrix_long %>%
            ungroup() %>%
            map_if(is.factor, as.character) %>%
            as_tibble() %>%
            fuzzy_join(specimen_control_defs_long, mode = "inner", by = c("Owner_Sample_ID" = "Control_Code"),
                       match_fun = function(x, y) str_detect(x, fixed(y, ignore_case = TRUE))) %>%

            filter(type.x == type.y) %>%
            arrange(Owner_Sample_ID, type.x) %>%
            select(Owner_Sample_ID, barcode, Control_Code, type = type.x, simple_status, status_control = status) %>%

        # 3. calculate result

            mutate(control_value = ifelse(simple_status == status_control, 0, 1)) %>%
            mutate(control_value = as.integer(control_value)) %>%
            group_by(Owner_Sample_ID, barcode) %>%
            mutate(failed_type_sum = sum(control_value)) %>%
            ungroup()

        control_results_final = control_results_pre %>%
            select(Control_Code, Owner_Sample_ID, barcode, failed_type_sum) %>%
            distinct() %>%
            mutate(control_result = ifelse(failed_type_sum == 0, "pass", "fail")) %>%
            select(-failed_type_sum, barcode, Owner_Sample_ID, Control_Code, control_result) %>%
            inner_join(simple_pn_matrix) %>%
            write_csv("control_results.csv")


print("line 188")

     samples_only_pn_matrix = simple_pn_matrix %>%
        left_join(select(control_results_final, barcode, Control_Code)) %>%
        filter(is.na(Control_Code)) %>%
        select(-Control_Code) %>%
        glimpse() %>%
        write_csv("samples_only_matrix_results.csv")

    failed_samples_only_pn_matrix = samples_only_pn_matrix %>%
        filter(str_detect(human_control, fixed("fail", ignore_case = TRUE))) %>%
        glimpse() %>%
        write_csv("failed_samples_matrix_results.csv")


    # # identify lineages ----
    lineage_defs = read_csv(lineage_defs) %>%
        map_if(is.factor, as.character) %>%
        as_tibble() %>%
        rename(CHROM = Chr, POS = Base_num, REF = Base_ID, ALT = vcf_variant)

    lineage_filtered = variants %>%
        right_join(lineage_defs) %>%
        write_csv("variants_test_results.csv") %>% 
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
        mutate(qc_reason = ifelse(qc_reason == "", "Pass", qc_reason)) %>% 
        mutate(lineage_status = ifelse(qc_reason != "Pass", 1, 0)) %>%
        group_by(barcode, Lineage_ID) %>%
        mutate(lineage_status_sum = sum(lineage_status)) %>%
        mutate(AF = ifelse(lineage_status_sum == 0, AF, 0)) %>%
        select(barcode, CHROM, POS, Lineage_ID, AF) %>%
        write_csv("lineage_filtered_results.csv")

        #mutate(AF = scales::percent(AF)) %>%
        #spread(Lineage_ID, AF) %>%
        #distinct() %>%
        #replace(is.na(.), "0%")

    lineage_manifest = manifest %>%
        mutate(barcode = paste0(BC1, BC2)) %>%
      write_csv("lineage_results.csv")
    #inner_join(lineage_filtered) %>%
     #   select(-BC1, -BC2) %>%
      #  write_csv("lineage_results.csv")

}
