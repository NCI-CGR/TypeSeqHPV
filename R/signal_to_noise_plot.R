signal_to_noise_plot <- function(read_count_matrix_report, detailed_pn_matrix_for_report, pn_filters){

# merge final pn matrix and read_counts_matrix_wide
signalNoiseDf1 = read_count_matrix_report %>%
# inner_join(final_pn_matrix, by=c("barcode", "HPV_Type")) %>%
inner_join(detailed_pn_matrix_for_report %>% gather(HPV_Type, hpvStatus, starts_with("HPV")), by=c("barcode", "HPV_Type", "Owner_Sample_ID")) %>%
filter(HPV_Type!="B2M") %>%
select(barcode, HPV_Type, HPV_Type_count, hpvStatus) %>%
#sort by types and count
# group by type, pn status (pos/neg)
group_by(hpvStatus, HPV_Type) %>%
arrange(HPV_Type_count) %>%
mutate(posOrder = 1:n()) %>%
arrange(desc(HPV_Type_count)) %>%
mutate(negOrder = 1:n()) %>%
ungroup()

signalNoiseDf = signalNoiseDf1 %>%
mutate(plotOrder = ifelse(hpvStatus == "pos", posOrder, negOrder)) %>%
select(HPV_Type, hpvStatus, HPV_Type_count, plotOrder) %>%
# select top 10 lowest count positives and 5 highest negatives ()
filter(plotOrder <= 10) %>%
transform(HPV_Type_count = as.integer(HPV_Type_count)) %>%
group_by(HPV_Type, hpvStatus) %>% 
# find mean!
summarize(meanCount = mean(HPV_Type_count)) %>%
transform(meanCount = as.numeric(meanCount)) %>%
ungroup() %>%
do({
temp = as_tibble(.)

tempReturn = pn_filters %>%
mutate(hpvStatus = "min_reads") %>%
rename(meanCount = Min_reads_per_type) %>%
transform(meanCount = as.numeric(meanCount)) %>%
select(HPV_Type = CHROM, hpvStatus, meanCount) %>%
semi_join(temp, by="HPV_Type") %>%
bind_rows(temp)

}) %>%

#better x axis sorting
separate(HPV_Type, c("temp", "hpvNum"), "HPV", remove=FALSE) %>%
select(-temp) %>%
mutate(hpvNum = ifelse(HPV_Type == "B2M_L" | HPV_Type == "B2M_S",1,hpvNum)) %>%
separate(hpvNum, c("hpvNum2", "temp"), "_", remove=FALSE) %>%
select(-temp) %>% 
separate(hpvNum2, c("hpvNum3", "temp"), "_", remove=FALSE) %>%
select(-temp) %>% group_by(HPV_Type) %>% 
#separate(hpvNum3, c("hpvNum4", "temp"), "v", remove=FALSE) %>%
select(HPV_Type, hpvNum = hpvNum3,hpvStatus, meanCount) %>%
distinct() %>%
#mutate(n = 1:n()) %>%
#group_by(HPV_Type) %>%
#mutate(num = row_number()) %>%
mutate(hpvNum = as.integer(hpvNum)) %>%
spread(hpvStatus, meanCount) %>%
arrange(hpvNum) %>%
ungroup() %>%
transform(HPV_Type = as.character(HPV_Type)) %>%
#mutate(HPV_Type = factor(HPV_Type, as.character(HPV_Type))) %>%
mutate(riskStatus = case_when(
                              HPV_Type=="HPV16" ~ "high risk HPV",
                              HPV_Type=="HPV18" ~ "high risk HPV",
                              HPV_Type=="HPV31" ~ "high risk HPV",
                              HPV_Type=="HPV33" ~ "high risk HPV",
                              HPV_Type=="HPV35" ~ "high risk HPV",
                              HPV_Type=="HPV39" ~ "high risk HPV",
                              HPV_Type=="HPV45" ~ "high risk HPV",
                              HPV_Type=="HPV51" ~ "high risk HPV",
                              HPV_Type=="HPV52" ~ "high risk HPV",
                              HPV_Type=="HPV56" ~ "high risk HPV",
                              HPV_Type=="HPV58" ~ "high risk HPV",
                              HPV_Type=="HPV59" ~ "high risk HPV",
                              HPV_Type=="HPV68" ~ "high risk HPV",
                          #    HPV_Type=="68b" ~ "high risk HPV",
                              TRUE ~ "low risk HPV")) %>%   #DF8F44FF
mutate(textColor = ifelse(riskStatus == "high risk HPV", "#FF7D33", "#00A1D5FF")) %>%
select(HPV_Type,riskStatus, textColor, Cneg = neg, Bpos = pos, Amin_reads = min_reads) %>%
group_by(HPV_Type,riskStatus, textColor) %>%
gather(hpvStatus, meanCount, Bpos, Cneg, Amin_reads, -HPV_Type, -riskStatus, -textColor)

#plot - two trend lines and log base 10 scale for y
returnPlot = ggplot(signalNoiseDf, aes(x=HPV_Type, y=meanCount, color=hpvStatus, group=hpvStatus)) +
geom_line() +
scale_y_log10(labels = scales::comma, breaks=c(0, 1, 10, 100, 1000, 10000, 100000, 1e6)) +
theme_light() +
theme(
      axis.text.y = element_text(angle = 0, hjust = 1, color = "darkblue", size = 18),
      axis.text.x = element_text(angle = 90, hjust = 0, color = signalNoiseDf$textColor, size = 18, vjust = 0.5),
      axis.line = element_line(colour = "darkblue",  size = 2, linetype = "solid")) +
theme(strip.background = element_blank(),
      legend.position="none") +
labs(title="Signal to Noise for Current Ion Torrent Run", x= "HPV Types", y = "Average Counts", size=18) +
theme(axis.text=element_text(size=18), axis.title=element_text(size=18,face="bold"), 
      plot.title = element_text(size=18, face="bold")) +
theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(0.5, 0.5, 0.5, 0, "cm"),
  plot.background = element_rect(
    fill = "grey90",
    colour = "black",
    size = 1)) 
#scale_color_igv()

print(returnPlot)

return(signalNoiseDf1)
}


