#' HPV Positivity Table
#'


hpv_positivity_table <- function(split_deilverables){

controls_df = split_deliverables$control_matrix %>%
filter(Control_type == "neg") %>%
group_by(Assay_Plate_Code, control_result) %>%
summarize(count = n()) %>%
bind_rows(data_frame(Assay_Plate_Code = "temp", control_result = c("pass", "fail"), count = c(0,0))) %>%
spread(control_result, count, fill=0) %>%
select(Assay_Plate_Code, `number negative controls passed` = pass, `number negative controls failed`=fail) 

samples_and_controls_df = split_deliverables$samples_only_matrix %>%
mutate(has_positive = ifelse(Num_Types_Pos == 0,0, 1)) %>%
group_by(Assay_Plate_Code) %>%
mutate(number_of_samples = n()) %>%
mutate(hpv_pos_rate = sum(has_positive) / number_of_samples) %>%
select(Assay_Plate_Code, hpv_pos_rate) %>%
distinct() %>%
mutate(hpv_pos_perc = scales::percent(hpv_pos_rate)) %>%
select(-hpv_pos_rate) %>%
left_join(controls_df) %>%
arrange(Assay_Plate_Code) %>%
rename(`Assay Plate Code` = Assay_Plate_Code, `HPV % Positive`= hpv_pos_perc) %>%
  
write_csv("hpv_positivity_table.csv")

panderOptions("table.split.table", 100)
panderOptions("table.split.cells", 5)

pandoc.table(samples_and_controls_df, style = "grid", caption = "HPV Positivity", 
             justify = c('right', 'left', 'left', 'left'))
  
return(samples_and_controls_df)

}
