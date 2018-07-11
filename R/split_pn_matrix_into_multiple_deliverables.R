#'

split_pn_matrix_into_multiple_deliverables <- function(final_pn_matrix, control_results){

samples_only_matrix = final_pn_matrix %>%
filter(control_result == "sample") %>%
select(-control_result) %>%
select(Project, 1:length(.), starts_with("HPV")) 

failed_samples_matrix = samples_only_matrix %>%
filter(Human_Control == "failed_to_amplify") %>%
select(-Control_type)

control_matrix = control_results %>%
left_join(final_pn_matrix) %>%
arrange(Control_Code, Owner_Sample_ID) 

temp = list(samples_only_matrix = samples_only_matrix, failed_samples_matrix = failed_samples_matrix, control_matrix = control_matrix)  

}
