#' plate_summary
#'

plate_summary <- function(control_for_report,samples_only_for_report){

    require(pander)

    controls_df = control_for_report %>%
        transform(Assay_Plate_Code = as.character(Assay_Plate_Code)) %>%
        mutate(Assay_Plate_Code = ifelse(is.na(as.character(Assay_Plate_Code)),
               "NA", Assay_Plate_Code)) %>%
        group_by(Assay_Plate_Code, Control_Code, control_result) %>%
        summarize(count = n()) %>%
        ungroup() %>% 
        mutate(control_result = paste0(Control_Code, "_", control_result)) %>%
        select(-Control_Code) %>%
        bind_rows(
            data_frame(Assay_Plate_Code = "temp",
                       control_result = c("pos_pass", "pos_fail",
                                          "neg_pass", "neg_fail"),
                       count = c(0,0,0,0))) %>%
        spread(control_result, count, fill = 0) %>%
        filter(Assay_Plate_Code != "temp") %>%
        mutate(total_controls = neg_fail + neg_pass + pos_fail + pos_pass) %>% 
        select(Assay_Plate_Code, pos_fail, neg_fail, total_controls)



    samples_and_controls_df = samples_only_for_report %>% 
        mutate(has_positive = ifelse(Num_Types_Pos == 0,0, 1)) %>%
        group_by(Assay_Plate_Code) %>%
        mutate(number_of_samples = n()) %>%
        mutate(plate_total_reads = sum(total_reads, na.rm = TRUE)) %>%
     #   mutate(plate_b2m_reads = sum(B2M, na.rm = TRUE)) %>%
        mutate(sample_status_for_count = ifelse(human_control == "failed_to_amplify", 1, 0)) %>%
        mutate(hpv_pos_rate = sum(has_positive) / number_of_samples) %>%
        mutate(num_samples_failed = sum(sample_status_for_count)) %>%
        select(Assay_Plate_Code, number_of_samples, plate_total_reads,
               hpv_pos_rate, num_samples_failed) %>%
        distinct() %>%
        drop_na %>%
        mutate(hpv_pos_perc = scales::percent(hpv_pos_rate)) %>%
      #  mutate(perc_b2m_reads = scales::percent(plate_b2m_reads / plate_total_reads)) %>%
      #  mutate(plate_b2m_reads = scales::comma(plate_b2m_reads)) %>%
        mutate(plate_total_reads = scales::comma(plate_total_reads)) %>%
        select(-hpv_pos_rate) %>%
        transform(Assay_Plate_Code = Assay_Plate_Code) %>%
        left_join(controls_df, by = "Assay_Plate_Code") %>%
        arrange(Assay_Plate_Code) 
       

    panderOptions("table.split.cells", 5)

    samples_and_controls_df %>%
        select(`Assay Plate Code` = Assay_Plate_Code,
               `HPV % Positive` = hpv_pos_perc,
               `total reads` = plate_total_reads,
               `# samples total` = number_of_samples,
               `# samples failed` = num_samples_failed,
        ) %>%

        pandoc.table(style = "multiline",
                     caption = "Assay Plate Performance")
    
}
