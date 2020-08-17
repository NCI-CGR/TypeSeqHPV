#'
#'control_summary

#Using detailed_pn_matrix, manifest and control results

Internal_control_summary <- function(detailed_pn_matrix_for_report,manifest,control_for_report,specimen_control_defs){
  detailed_pn_matrix_for_report %>%
  inner_join(manifest %>% mutate(barcode = paste0(BC1,BC2)) %>% select(-BC1,-BC2)) %>% 
  full_join(control_for_report %>% select(Owner_Sample_ID,Control_Code)) %>%
  select(barcode,Owner_Sample_ID,ASIC_Low,ASIC_Med,ASIC_High,B2M_L,B2M_S,ESIC_High,ESIC_Low,ESIC_Med,Assay_Plate_Code,Assay_SIC,Ext_SIC,human_control) %>%
  distinct() %>%
  mutate(num = 1) %>%
  mutate(plate_sum = sum(num)) %>%
  mutate(ASIC_num = ifelse(Assay_SIC == "pass",1,0)) %>%
  mutate(ESIC_num = ifelse(Ext_SIC == "pass",1,0)) %>% 
  drop_na() %>%
  mutate(plate_ASIC = sum(ASIC_num),plate_ESIC = sum(ESIC_num)) %>% 
  mutate(plate_ASIC_perc = scales::percent(plate_ASIC/plate_sum), plate_ESIC_perc = scales::percent(plate_ESIC/plate_sum)) %>%
  group_by(Assay_Plate_Code) %>%
  mutate(num = sum(num)) %>%
  mutate(ASIC_num = sum(ASIC_num), ESIC_num = sum(ESIC_num)) %>%
  mutate(Perc_ASIC_passed = scales::percent(ASIC_num/num), Perc_ESIC_passed = scales::percent(ESIC_num/num)) %>%
  ungroup() %>%
  select(Assay_Plate_Code,Perc_ASIC_passed,Perc_ESIC_passed, plate_ASIC_perc,plate_ESIC_perc) %>%
  distinct() %>%
  add_row(Assay_Plate_Code = "All_plates",Perc_ASIC_passed = unique(.$plate_ASIC_perc), Perc_ESIC_passed = unique(.$plate_ESIC_perc))%>%
  select(Assay_Plate_Code,Perc_ASIC_passed,Perc_ESIC_passed) -> control_df1


#Doing the B2M calculation seperately since B2M is being calculated only in samples while other 
#internal controls are being calculated on controls and samples.

control_df2 = detailed_pn_matrix_for_report %>%
  inner_join(manifest %>% mutate(barcode = paste0(BC1,BC2)) %>% select(-BC1,-BC2)) %>% 
  full_join(control_for_report %>% select(Owner_Sample_ID,Control_Code)) %>%
  filter(is.na(Control_Code)) %>%
  select(barcode,Owner_Sample_ID,human_control,Assay_Plate_Code) %>%
  distinct() %>%
  mutate(B2M_num = ifelse(human_control == "pass",1,0)) %>%
  mutate(num = 1) %>%
  mutate(plate_sum = sum(num)) %>%
  mutate(plate_B2M = sum(B2M_num)) %>%
  mutate(plate_B2M_perc = scales::percent(plate_B2M/plate_sum)) %>%
  group_by(Assay_Plate_Code) %>%
  mutate(num = sum(num)) %>%
  mutate(B2M_num = sum(B2M_num)) %>%
  mutate(Perc_B2M_passed = scales::percent(B2M_num/num)) %>%
  ungroup() %>%
  select(Assay_Plate_Code,Perc_B2M_passed, plate_B2M_perc) %>%
  distinct() %>% 
  drop_na() %>%
  add_row(Assay_Plate_Code = "All_plates", Perc_B2M_passed  = unique(.$plate_B2M_perc)) %>%
  inner_join(control_df1) %>%
  select(-plate_B2M_perc)

 panderOptions("table.split.table", 100)
 panderOptions("table.split.cells", 4)
 
 control_df2 %>%
   pandoc.table(style = "multiline",
                caption = "Internal Control Summary")
 

 #table5 
 
 control_df3 = control_for_report %>%
   select(barcode,Owner_Sample_ID,Control_Code,control_result) %>%
   distinct() %>%
   inner_join(specimen_control_defs) %>%
   full_join(manifest %>% mutate(barcode = paste0(BC1,BC2)) %>% select(barcode, Owner_Sample_ID,Assay_Plate_Code)) %>%
   select(barcode, Owner_Sample_ID, Control_Code,control_result,Control_type,Assay_Plate_Code) %>%
   mutate(Num_Pos_Con_Passed = ifelse(control_result == "pass" & Control_type == "pos", 1,0)) %>%
   mutate(Num_Neg_Con_Passed = ifelse(control_result == "pass" & Control_type == "neg", 1,0)) %>% 
   mutate(Num_Pos_Con_Passed = ifelse(is.na(Num_Pos_Con_Passed),0,Num_Pos_Con_Passed),Num_Neg_Con_Passed = ifelse(is.na(Num_Neg_Con_Passed),0,Num_Neg_Con_Passed)) %>%
   mutate(Num_pos_con_failed = ifelse(control_result == "fail" & Control_type == "pos", 1,0)) %>%
   mutate(Num_neg_con_failed = ifelse(control_result == "fail" & Control_type == "neg", 1,0)) %>%
   mutate(Num_pos_con_failed = ifelse(is.na(Num_pos_con_failed),0,Num_pos_con_failed),Num_neg_con_failed = ifelse(is.na(Num_neg_con_failed),0,Num_neg_con_failed)) %>%
   mutate(Num_sample_failed = ifelse(control_result == "pass",0,1)) %>% 
   group_by(Assay_Plate_Code) %>% 
   mutate(Num_Pos_Con_Passed = sum(Num_Pos_Con_Passed),Num_Neg_Con_Passed = sum(Num_Neg_Con_Passed),Num_pos_con_failed = sum(Num_pos_con_failed),Num_neg_con_failed= sum(Num_neg_con_failed)) %>%
   select(Assay_Plate_Code,Num_Pos_Con_Passed,Num_Neg_Con_Passed,Num_pos_con_failed,Num_neg_con_failed) %>%
   ungroup() %>%
   distinct() %>% drop_na() %>%
   add_row(Assay_Plate_Code = "All_plates", Num_Pos_Con_Passed = sum(.$Num_Pos_Con_Passed),Num_pos_con_failed = sum(.$Num_pos_con_failed),
           Num_Neg_Con_Passed = sum(.$Num_Neg_Con_Passed), Num_neg_con_failed = sum(.$Num_neg_con_failed))

 panderOptions("table.split.table", 100)
 panderOptions("table.split.cells", 5)
 
 control_df3 %>%
   pandoc.table(style = "multiline",
                caption = "Control Summary")
 
 
 }




