#
calculate_expected_control_results <- function(args_control_defs, initial_pn_matrix){
require(tidyverse)
require(fuzzyjoin)

           
# 1.  read in control defs
control_defs = read_csv(args_control_defs) %>%
map_if(is.factor, as.character) %>%
as_tibble() %>%
ungroup() %>%
tidyr::gather("type", "status", -Control_Code, -Control_type) %>%
arrange(Control_Code)


# 2.  merge pn matrix with control defs

control_results_pre = initial_pn_matrix %>%
ungroup() %>%
map_if(is.factor, as.character) %>%
as_tibble() %>%
select(Owner_Sample_ID, barcode, Human_Control, starts_with("HPV")) %>%
gather("type", "status", -Owner_Sample_ID, -barcode) %>%
fuzzy_join(control_defs, mode = "inner", by=c("Owner_Sample_ID" = "Control_Code"), match_fun = function(x, y) str_detect(x, fixed(y, ignore_case=TRUE))) %>%
filter(type.x == type.y) %>%
arrange(Owner_Sample_ID, type.y) %>%
select(Owner_Sample_ID, barcode, Control_Code, Control_type, type = type.x, type.y, status_pn = status.x, status_control = status.y) %>%

# 3. calculate result

mutate(control_value = ifelse(status_pn == status_control, 0, 1)) %>%
mutate(control_value = as.integer(control_value)) %>%
group_by(Owner_Sample_ID, barcode) %>%
mutate(failed_type_sum = sum(control_value)) %>%
ungroup() 
           
control_results_final = control_results_pre %>%         
select(Control_Code, Owner_Sample_ID, barcode, Control_type, failed_type_sum) %>%
distinct() %>%
mutate(control_result = ifelse(failed_type_sum==0, "pass", "fail")) %>%
select(-failed_type_sum) %>%
arrange(Control_Code, Owner_Sample_ID, barcode)

return(list(control_results_pre = control_results_pre, control_results_final = control_results_final))
}
