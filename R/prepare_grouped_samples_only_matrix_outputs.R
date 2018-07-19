#'

prepare_grouped_samples_only_matrix_outputs <- function(args_custom_groups_path, samples_only_matrix){

########### make groupsDf and long form Samples Matrix and merge #################
groupsDf = read_csv(args_custom_groups_path) %>%
gather(HPV_Type, reportingStatus, starts_with("HPV")) %>%
select(hpvType = HPV_Type, Panel = Sample_Sheet_Panel_Name, Group_Name, reportingStatus) %>%
arrange(hpvType, Panel)

########### make long form Samples Matrix and merge #################
samplesOnlyMatrixLongWithGroupInfo = samples_only_matrix %>%
gather(hpvType, hpvStatus, starts_with("HPV")) %>%
merge(groupsDf) %>%
mutate(temp_group_name = case_when(is.na(Group_Name) & reportingStatus=="mask" ~ "masked", 
                                   is.na(Group_Name) & is.na(reportingStatus) ~ "not_masked_and_not_grouped_Num_Types_Pos",
                                   TRUE ~ Group_Name)) %>%
mutate(hpv_status_numerical = ifelse(hpvStatus=="neg", 0,1)) %>%
mutate(hpv_status_numerical = as.integer(hpv_status_numerical)) %>%
group_by(barcode, temp_group_name) %>%
mutate(grouped_Num_Types_Pos  = sum(hpv_status_numerical)) %>%
ungroup() %>%
#mutate(grouped_Num_Types_Pos  = ifelse(temp_group_name=="masked", 0, grouped_Num_Types_Pos)) %>%
select(-hpv_status_numerical)
num_types_pos_df = samplesOnlyMatrixLongWithGroupInfo %>%
select(barcode, temp_group_name, grouped_Num_Types_Pos) %>%
distinct() %>%
group_by(temp_group_name) %>%
mutate(grouped_id = row_number()) %>%
spread(temp_group_name, grouped_Num_Types_Pos) %>%
select(-grouped_id)

samplesOnlyMatrixLongWithGroupInfoNoTypeCount = samplesOnlyMatrixLongWithGroupInfo %>%
select(-Num_Types_Pos, -temp_group_name, -grouped_Num_Types_Pos)

######## create new grouped columns ###############
groupedColumnsSamplesOnlyMatrix = samplesOnlyMatrixLongWithGroupInfoNoTypeCount %>%
filter(!is.na(Group_Name)) %>%
mutate(groupPNStatus = ifelse(hpvStatus == "neg", 0, 1)) %>%
group_by(Panel, Group_Name, barcode) %>%
mutate(groupPNStatusSum = sum(groupPNStatus)) %>%
mutate(hpvStatus = ifelse(groupPNStatusSum > 0 ,"pos", "neg")) %>%
select(-reportingStatus, -groupPNStatus, -groupPNStatusSum, -hpvType) %>%
rename(hpvType = Group_Name) %>%
ungroup() %>%
distinct()

######## filter based on reporting status ###############
maskedSamplesOnlyMatrix = samplesOnlyMatrixLongWithGroupInfoNoTypeCount %>%
filter(is.na(reportingStatus)) 

##### spread back into wide form ############
finalGroupedSamplesOnlyMatrix = bind_rows(maskedSamplesOnlyMatrix, 
                                          groupedColumnsSamplesOnlyMatrix) %>%
merge(num_types_pos_df) %>%
spread(hpvType, hpvStatus) %>%
select(-Group_Name, -reportingStatus) %>%
gather("HPV_Type", "status", starts_with("HPV")) %>%
left_join(parameters_df %>% select(HPV_Type, display_order)) %>% # <- merge with parameters file to get display order
mutate(HPV_Type = factor(HPV_Type, levels=unique(HPV_Type[order(display_order)]), ordered=TRUE)) %>%
select(-display_order) %>%
group_by(barcode) %>%
spread(HPV_Type, status) # <- tranform from long form to actual matrix  
  
  
  
return(finalGroupedSamplesOnlyMatrix)
}
