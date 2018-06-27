#'
finalize_pn_matrix <- function(initial_pn_matrix, filtering_criteria, control_results) {
  
final_pn_matrix = initial_pn_matrix %>%
left_join(control_results) %>%
mutate(control_result = if_else(is.na(control_result), "sample", control_result)) %>%
select(-Control_Code) %>%
distinct() %>%
select(-Num_Types_Pos, -control_result, -Human_Control, -starts_with("HPV"), control_result, Num_Types_Pos, Human_Control, starts_with("HPV")) %>%
arrange(Sort_Order) %>%
mutate(Num_Types_Pos = ifelse(is.na(Num_Types_Pos), 0, Num_Types_Pos))
}
