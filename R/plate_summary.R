#' plate_summary
#'

hpv_positivity_table <- function(split_deliverables){

controls_df = split_deliverables$control_matrix %>%
mutate(extraction_plate_id = paste(Ext_Lab, Ext_Operator, Ext_Method,
                                       Ext_Date, sep = "_")) %>%
group_by(extraction_plate_id, Assay_Plate_Code, Control_type, control_result) %>%
summarize(count = n()) %>%
ungroup() %>%
mutate(control_result = paste0(Control_type, "_", control_result)) %>%
select(-Control_type) %>%
bind_rows(
    data_frame(extraction_plate_id = "temp",
                    control_result = c("pos_pass", "pos_fail",
                                       "neg_pass", "neg_fail"),
                    count = c(0,0,0,0))) %>%
spread(control_result, count, fill = 0) %>%
select(extraction_plate_id , Assay_Plate_Code, pos_pass, pos_fail, neg_pass, neg_fail) %>%
filter(extraction_plate_id != "temp")

samples_and_controls_df = split_deliverables$samples_only_matrix %>%
mutate(extraction_plate_id = paste(Ext_Lab, Ext_Operator, Ext_Method,
                                       Ext_Date, sep = "_")) %>%
mutate(has_positive = ifelse(Num_Types_Pos == 0,0, 1)) %>%
group_by(extraction_plate_id, Assay_Plate_Code) %>%
mutate(number_of_samples = n()) %>%
mutate(plate_total_reads = sum(total_reads)) %>%
mutate(plate_b2m_reads = sum(B2M)) %>%
mutate(sample_status_for_count = ifelse(b2m_status == "fail", 1, 0)) %>%
mutate(hpv_pos_rate = sum(has_positive) / number_of_samples) %>%
mutate(num_samples_failed = sum(sample_status_for_count)) %>%
select(extraction_plate_id, Assay_Plate_Code, number_of_samples, plate_total_reads,
plate_b2m_reads, hpv_pos_rate, num_samples_failed) %>%
distinct() %>%
mutate(hpv_pos_perc = scales::percent(hpv_pos_rate)) %>%
mutate(perc_b2m_reads = scales::percent(plate_b2m_reads / plate_total_reads)) %>%
mutate(plate_b2m_reads = scales::comma(plate_b2m_reads)) %>%
mutate(plate_total_reads = scales::comma(plate_total_reads)) %>%
select(-hpv_pos_rate) %>%
left_join(controls_df) %>%
arrange(extraction_plate_id, Assay_Plate_Code) %>%
select(`Extraction plate ID` = extraction_plate_id,
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
write_csv("hpv_positivity_table.csv")

panderOptions("table.split.table", 100)
panderOptions("table.split.cells", 5)

pandoc.table(samples_and_controls_df, style = "multiline",
             caption = "Assay Plate Performance")

}
