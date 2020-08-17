#'

#library(gtools)
#library(gridExtra)
library(dplyr)


#Date of completion - 02/07/2020
#This scripts creates plate maps for 2 internal control types(ASIC and B2M) and batch controls.
#Takes in manifest, detailed_pn_matrix_for_report and control_results.


#Plate map for ASICs
plate_map <- function(manifest,detailed_pn_matrix_for_report, specimen_control_defs,control_for_report){

  plate_data <- manifest %>%
    mutate(barcode = paste0(BC1,BC2)) %>%
    full_join(specimen_control_defs %>% select(Control_Code,Control_type) %>%
              mutate(Owner_Sample_ID = Control_Code),
              by = "Owner_Sample_ID") %>%
    inner_join(detailed_pn_matrix_for_report, by = c("barcode","Owner_Sample_ID")) %>%
    gather(type,status,starts_with("ASIC")) %>%
    mutate(count = ifelse(status == "pos",1,0)) %>%
    select(barcode,Owner_Sample_ID,Assay_SIC,Assay_Well_ID,Assay_Plate_Code,Control_Code,type,status,count) %>%
    group_by(barcode,Owner_Sample_ID,Assay_Plate_Code) %>%
    mutate(sum_count = sum(count)) %>%
    select(-count)%>%
    spread(type,status) %>%
    mutate(color = "white") %>% 
    mutate(color = ifelse(sum_count == 0,"0/3_present",color)) %>%
    mutate(color = ifelse(sum_count == 1,"1/3_present",color)) %>%
    mutate(color = ifelse(sum_count == 2,"2/3_present",color)) %>%
    mutate(color = ifelse(sum_count == 3,"3/3_present",color)) %>%
    mutate(Control_Code = ifelse(is.na(Control_Code),"sample","control")) %>%
    separate(Assay_Well_ID,c("rownum","colnum"),sep =1) %>%
    drop_na()

  
#Create empty wells to make sure we get a proper 96 well plate

well_num = seq(1,12,length.out = 12)  
well_ID = LETTERS[1:8]
empty_wells = as.data.frame(expand.grid(rownum=well_ID, colnum= well_num,stringsAsFactors = F))

#Loop over plates and make a plot for each plate

plot_list = list()
for (i in unique(plate_data$Assay_Plate_Code)) {
  plate_data %>%
    filter(Assay_Plate_Code == i)  -> data
  data %>% 
    full_join(empty_wells %>% transform(colnum = as.factor(colnum), rownum = as.factor(rownum))) %>%
    mutate(color = ifelse(is.na(color),"empty",color)) %>%
    mutate(Control_Code = ifelse(is.na(Control_Code),"empty",Control_Code)) -> data
   # mutate(colnum = fct_reorder(colnum, desc(as.numeric(colnum)))) 
  
  data = data[order(as.numeric(as.character(data$colnum))),]
  cols = c("0/3_present" = "red","1/3_present" = "yellow","2/3_present"="orange","3/3_present"="green","empty"="grey")
  plot = ggplot(data, aes(y = fct_reorder(rownum,desc(rownum)),x = fct_reorder(colnum,sort(as.numeric(data$colnum))),shape = Control_Code)) + 
    geom_point(aes(colour = color), size =12) + 
    scale_shape_manual(values = c("empty"=16,"control"=17,"sample"=16), limits = c("empty","control","sample"))+
    scale_color_manual(values = cols) + theme_bw() +
    labs(x= i, y = "ASIC_plate_map")+
    ggtitle("ASIC plate map")
  
 # plot_list[[i]] = plot
  print(plot)
}

#gridExtra::grid.arrange(grobs = plot_list, nrow = 6, ncol =2, newpage = T)
##ggplotGrob(plot_list)

#plate map for BM2s

  plate_data <- manifest %>%
  mutate(barcode = paste0(BC1,BC2)) %>%
  full_join(specimen_control_defs %>% select(Control_Code,Control_type) %>%
               mutate(Owner_Sample_ID = Control_Code),
             by = "Owner_Sample_ID") %>%
  inner_join(detailed_pn_matrix_for_report, by = c("barcode","Owner_Sample_ID")) %>%
  gather(type,status,starts_with("B2M")) %>%
  mutate(count = ifelse(status == "pos",1,0)) %>%
  select(barcode,Owner_Sample_ID,Assay_SIC,Assay_Well_ID,Assay_Plate_Code,Control_Code,type,status,count) %>%
  group_by(barcode,Owner_Sample_ID,Assay_Plate_Code) %>%
  mutate(sum_count = sum(count)) %>%
  select(-count)%>%
  spread(type,status) %>%
  mutate(color = "white") %>% 
  mutate(color = ifelse(sum_count == 0,"0/2_present",color)) %>%
  mutate(color = ifelse(sum_count == 1,"1/2_present",color)) %>%
  mutate(color = ifelse(sum_count == 2,"2/2_present",color)) %>%
  mutate(Control_Code = ifelse(is.na(Control_Code),"sample","control")) %>% 
  separate(Assay_Well_ID,c("rownum","colnum"),sep =1) %>%
  drop_na() 
  plate_data <-as.data.frame(plate_data)
#Create empty wells
well_num = seq(1,12,length.out = 12)  
well_ID = LETTERS[1:8]
empty_wells = as.data.frame(expand.grid(rownum=well_ID, colnum= well_num,stringsAsFactors = F))


#Plot the plates
plot_list = list()
for (i in unique(plate_data$Assay_Plate_Code)) {
  plate_data %>%
    filter(Assay_Plate_Code == i)  -> data
  data %>%
    full_join(empty_wells %>% transform(colnum = as.character(colnum), rownum = as.factor(rownum))) %>%
    mutate(color = ifelse(is.na(color),"empty",color)) %>%
    mutate(Control_Code = ifelse(is.na(Control_Code),"empty",Control_Code)) -> data
 
  data = data[order(as.numeric(as.character(data$colnum))),]
  cols = c("0/2_present"="red","1/2_present"="yellow","2/2_present" = "green","empty"="grey")
  plot = ggplot(data, aes(x = fct_reorder(colnum,sort(as.numeric(data$colnum))),y = fct_reorder(rownum,desc(rownum)),shape = Control_Code)) + 
    geom_point(aes(colour = color), size =12) +
    scale_shape_manual(values = c("empty"=16,"control"=17,"sample"=16), limit = c("empty","control","sample"), drop = F) +
    scale_color_manual(values = cols, limits = c("0/2_present","1/2_present","2/2_present","empty"),  drop = F) +
    labs(x= i, y = "TypeSeqHPV_plate_data")+
    ggtitle("B2M/Human_control plate map")
    

  print(plot)
 # plot_list[[i]] = plot
  
}

#print(gridExtra::grid.arrange(grobs = plot_list,  nrow = 6,ncol = 2, newpage = T))



#B2M_plot(manifest,detailed_pn_matrix_for_report)

#Plate map for all batch-controls

#batch_control_plot = function(control_results_final,specimen_control_defs,detailed_pn_matrix_for_report) {

  plate_data <- control_for_report %>% 
  select(barcode, Owner_Sample_ID,control_result) %>% 
  inner_join(specimen_control_defs %>% select(Control_Code,Control_type), by =c("Owner_Sample_ID" ="Control_Code")) %>%
  full_join(detailed_pn_matrix_for_report %>% select(barcode,Owner_Sample_ID)) %>%
  transform(Control_type = as.character(Control_type)) %>%
  mutate(control_result = ifelse(is.na(control_result),"sample",control_result)) %>%
  mutate(Control_type = ifelse(is.na(Control_type),as.character("sample"),Control_type)) %>%
  inner_join(manifest %>% mutate(barcode = paste0(BC1,BC2)),by = c("barcode","Owner_Sample_ID")) %>% 
  select(barcode,Owner_Sample_ID,control_result, Control_type, Assay_Plate_Code,Assay_Well_ID) %>%
  mutate(color = "white") %>%
  mutate(color = ifelse(control_result == "pass" & Control_type == "pos","pos_pass",color)) %>%
  mutate(color = ifelse(control_result == "fail" & Control_type == "pos",'pos_fail',color)) %>%
  mutate(color = ifelse(control_result == "pass" & Control_type == "neg",'neg_pass',color)) %>%
  mutate(color = ifelse(control_result == "fail" & Control_type == "neg",'neg_fail',color)) %>%
  mutate(color =ifelse(control_result == "sample","sample",color)) %>%
  mutate(Control_code = ifelse(Control_type == "sample","sample",Owner_Sample_ID)) %>%
  separate(Assay_Well_ID,c("rownum","colnum"),sep =1) %>%
  drop_na() 

# creat empty wells
well_num = seq(1,12,length.out = 12)  
well_ID = LETTERS[1:8]
empty_wells = as.data.frame(expand.grid(rownum=well_ID, colnum= well_num,stringsAsFactors = F))


plot_list = list()
for (i in unique(plate_data$Assay_Plate_Code)) {
  plate_data %>%
    filter(Assay_Plate_Code == i)  -> data
  
  data %>% 
    full_join(empty_wells %>% transform(colnum = as.character(colnum), rownum = as.factor(rownum))) %>% 
    mutate(color = ifelse(is.na(color),"empty",color)) %>%
    mutate(Owner_Sample_ID = ifelse(is.na(Owner_Sample_ID), "empty",Owner_Sample_ID)) %>%
    mutate(control_result = ifelse(is.na(control_result),"empty",control_result)) %>%
    mutate(Control_type =ifelse(is.na(Control_type), "empty",Control_type))%>%
    mutate(Control_code = ifelse(is.na(Control_code),"empty",Control_code)) %>%
    mutate(Control_code = ifelse(Control_code != "sample" & Control_code != "empty","control",Control_code)) -> data
  
  data = data[order(as.numeric(as.character(data$colnum))),]
  cols = c("pos_pass"='green',"pos_fail"='red',"neg_pass"='blue',"neg_fail"='yellow',"sample" ='white',"empty" ='grey')
  plot = ggplot(data, aes(x = fct_reorder(colnum,sort(as.numeric(data$colnum))),y = fct_reorder(rownum,desc(rownum)), shape = Control_code)) + 
    geom_point(aes(colour = color), size =12) +
    scale_shape_manual(name = "Shape", values = c("sample"= 16,"control" = 17,"empty"= 16),limits = c("sample","control","empty"), drop = FALSE) +
    scale_color_manual(name = "Color",values = cols, limits = c("pos_pass","pos_fail","neg_pass","neg_fail","sample","empty")) +
    labs(x= i, y = "TypeSeqHPV_plate_data") +
    scale_x_discrete(limits = rev(levels(data$colnum))) +
    ggtitle("All batch control plate map")
  
 # plot_list[[i]] = plot
  
  print(plot)
  
}

#print(gridExtra::grid.arrange(grobs =plot_list,  nrow = 6))


}

#}
