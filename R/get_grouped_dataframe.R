#' This script takes the simple_pn_matrix and grouping defs and makes new pn_matrix according to the groups mentioned in the defs file
#' Assumptions: Panel in the Sample sheet should always match the Sample_Sheet_Panel_Name in the grouping defs. 
#' If the grouping type is "mask" then it will be removed from the final table. If grouping type is Onco contigs labelled Onco will be grouped together as Onco.
#' 


#Grouping and masking


get_grouped_df<- function(simple_pn_matrix_final,groups_defs,ion_qc_report){
simple_pn_matrix_final %>%
    filter(!is.na(Owner_Sample_ID)) %>%
    transform(Panel = as.character(Panel)) %>%
    mutate(Panel = ifelse(is.na(Panel),"All",Panel)) %>%
    gather(type,status, starts_with("HPV")) %>%
    inner_join(groups_defs %>% gather(type,mask, starts_with("HPV")) %>% rename(Panel = Sample_Sheet_Panel_Name)) %>%
    mutate(mask = ifelse(is.na(mask),"not_masked",mask)) %>%
    filter(Panel != "All") -> grouped
  
  for (i in levels(factor(grouped$Panel))){
    
    grouped %>%
      filter(Panel == i) %>%
      filter(mask != "mask") %>%
      mutate(num_status = ifelse(status == "pos",1,0)) %>%
      group_by(barcode,Panel,mask) %>%
      mutate(sum = sum(num_status)) %>%
      ungroup() %>%
      group_by(barcode) %>%
      mutate(status = ifelse(sum != 0 & mask == "Onco","pos",status), new_type = ifelse(mask == "Onco","Onco",type)) %>% 
      select(-mask,-Group_Name, -num_status, -sum, -type) %>% 
      distinct() %>%
      spread(new_type,status) -> final_grouped
    outfile <- paste0(i,".","masked.csv")
    write.csv(final_grouped,outfile)
    
    
  }

}

  
  
  




