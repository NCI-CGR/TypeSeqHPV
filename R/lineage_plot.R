lineage_plot <- function(df, whichPlot){

lineage_plot_table = df %>%
#ungroup() %>%
gather(Lineage_ID, lineage_percent, starts_with("HPV")) %>%
mutate(lineage_percent = ifelse(is.na(lineage_percent), 0, lineage_percent)) %>% # really don't like this fix
#rename(lineage_percent = AF) %>%
mutate(lineage_found = ifelse(lineage_percent > 0, 1, 0)) %>%
group_by(Lineage_ID) %>%
mutate(typeCount = sum(lineage_found)) %>%
ungroup() %>%
mutate(HPV_Type = str_sub(Lineage_ID, end =5)) %>%
select(HPV_Type, Lineage_ID, typeCount) %>%
distinct() %>%
arrange(HPV_Type, Lineage_ID) %>%
group_by(HPV_Type) %>%
mutate(lineage_num = 1:n()) %>%
mutate(lineage_num = factor(lineage_num)) 
  
returnPlot1 = ggplot(lineage_plot_table, aes(x=Lineage_ID, y=typeCount, fill = lineage_num)) +
geom_bar(stat="identity", position = position_dodge(width=0.5)) +
  
theme_light() +
theme(
      axis.text.y = element_text(angle = 0, hjust = 1, color = "darkblue", size = 18),
      axis.text.x = element_text(angle = 90, hjust = 1, size = 18, vjust = 0.5),
      axis.line = element_line(colour = "darkblue",  size = 2, linetype = "solid")) +
theme(strip.background = element_blank(),
      legend.position="bottom",
     legend.text=element_text(size=16),
     legend.title=element_text(size=16)) +
labs(title="Lineage Distribution By Type.  Colors Represent Within Type Groupings", x= "Type", y = "Count", size=12) +
  theme(axis.text=element_text(size=18), axis.title=element_text(size=18,face="bold"), 
      plot.title = element_text(size=18, face="bold")) +
theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(0.5, 0.5, 0.5, 0, "cm"),
  plot.background = element_rect(
    fill = "grey90",
    colour = "black",
    size = 1)) +
scale_fill_igv() 
  
returnPlot2 = ggplot(lineage_plot_table, aes(x=HPV_Type, y=typeCount, fill = lineage_num)) +
geom_bar(stat="identity", position = "fill") +
  
theme_light() +
theme(
      axis.text.y = element_text(angle = 0, hjust = 1, color = "darkblue", size = 18),
      axis.text.x = element_text(angle = 90, hjust = 0, size = 18, vjust = 0.5),
      axis.line = element_line(colour = "darkblue",  size = 2, linetype = "solid")) +
theme(strip.background = element_blank(),
      legend.position="bottom", 
     legend.text=element_text(size=16), 
      legend.title=element_text(size=16)) +
labs(title="Normalized Lineage Distribution By Type.  Colors Represent Within Type Groupings", x= "Type", y="") +
theme(axis.text=element_text(size=18), axis.title=element_text(size=18,face="bold"), 
      plot.title = element_text(size=18, face="bold")) +  
   
theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(0.5, 0.5, 0.5, 0, "cm"),
  plot.background = element_rect(
    fill = "grey90",
    colour = "black",
    size = 1)) +
scale_fill_igv()  

if(whichPlot == 1){print(returnPlot1)}
if(whichPlot == 2){print(returnPlot2)}

return(lineage_plot_table)

}
