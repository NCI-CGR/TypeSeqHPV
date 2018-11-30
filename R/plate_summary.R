#' plate_summary
#'

plate_summary <- function(split_deliverables){

controls_df = split_deliverables$control_matrix %>%
group_by(PreExtraction_Plate_ID, Assay_Plate_Code, Control_type, control_result) %>%
summarize(count = n()) %>%
ungroup() %>%
mutate(control_result = paste0(Control_type, "_", control_result)) %>%
select(-Control_type) %>%
bind_rows(
    data_frame(PreExtraction_Plate_ID = "temp",
                    control_result = c("pos_pass", "pos_fail",
                                       "neg_pass", "neg_fail"),
                    count = c(0,0,0,0))) %>%
spread(control_result, count, fill = 0) %>%
select(PreExtraction_Plate_ID, Assay_Plate_Code, pos_pass, pos_fail, neg_pass, neg_fail) %>%
filter(PreExtraction_Plate_ID != "temp")

samples_and_controls_df = split_deliverables$samples_only_matrix %>%
mutate(has_positive = ifelse(Num_Types_Pos == 0,0, 1)) %>%
group_by(PreExtraction_Plate_ID, Assay_Plate_Code) %>%
mutate(number_of_samples = n()) %>%
mutate(plate_total_reads = sum(total_reads)) %>%
mutate(plate_b2m_reads = sum(B2M)) %>%
mutate(sample_status_for_count = ifelse(Human_Control == "fail", 1, 0)) %>%
mutate(hpv_pos_rate = sum(has_positive) / number_of_samples) %>%
mutate(num_samples_failed = sum(sample_status_for_count)) %>%
select(PreExtraction_Plate_ID, Assay_Plate_Code, number_of_samples, plate_total_reads,
plate_b2m_reads, hpv_pos_rate, num_samples_failed) %>%
distinct() %>%
mutate(hpv_pos_perc = scales::percent(hpv_pos_rate)) %>%
mutate(perc_b2m_reads = scales::percent(plate_b2m_reads / plate_total_reads)) %>%
mutate(plate_b2m_reads = scales::comma(plate_b2m_reads)) %>%
mutate(plate_total_reads = scales::comma(plate_total_reads)) %>%
select(-hpv_pos_rate) %>%
left_join(controls_df) %>%
arrange(PreExtraction_Plate_ID, Assay_Plate_Code)

panderOptions("table.split.cells", 5)


samples_and_controls_df %>%
select(`PreExtraction plate ID` = PreExtraction_Plate_ID,
       `Assay Plate Code` = Assay_Plate_Code,
       `HPV % Positive` = hpv_pos_perc,
       `# neg controls failed` = neg_fail,
       `# pos controls failed` = pos_fail,
       `# samples failed` = num_samples_failed,
       `# samples total` = number_of_samples,
       `total reads` = plate_total_reads,
       `total B2M reads` = plate_b2m_reads,
       `% B2M reads` = perc_b2m_reads
       ) %>%

pandoc.table(style = "multiline",
             caption = "Assay Plate Performance")

samples_and_controls_df %>%
    select(`PreExtraction plate ID` = PreExtraction_Plate_ID,
           `Assay Plate Code` = Assay_Plate_Code,
           `total reads` = plate_total_reads,
           `total B2M reads` = plate_b2m_reads,
           `% B2M reads` = perc_b2m_reads
    ) %>%

    pandoc.table(style = "multiline",
                 caption = "Assay Plate Performance")

}
