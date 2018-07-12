signal_to_noise_plot <- function(hpv_types, final_pn_matrix, filtering_criteria){

# merge final pn matrix and hpv_types
signalNoiseDf1 = hpv_types %>%
inner_join(final_pn_matrix %>% gather(HPV_Type, hpvStatus, starts_with("HPV")), by=c("barcode", "HPV_Type")) %>%
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
# select top five lowest count positives and 5 highest negatives () -
filter(plotOrder <= 5) %>%
group_by(HPV_Type, hpvStatus) %>%
# find mean!
summarize(meanCount = mean(HPV_Type_count)) %>%
ungroup() %>%
do({
temp = as_tibble(.)

tempReturn = filtering_criteria %>%
mutate(hpvStatus = "min_reads") %>%
select(HPV_Type = type_id, hpvStatus, meanCount = factored_min_reads_per_type) %>%
semi_join(temp, by="HPV_Type") %>%
bind_rows(temp)

}) %>%

#better x axis sorting
separate(HPV_Type, c("temp", "hpvNum"), "HPV", remove=FALSE) %>%
select(-temp) %>%
separate(hpvNum, c("hpvNum2", "temp"), "a", remove=FALSE) %>%
select(-temp) %>%
separate(hpvNum2, c("hpvNum3", "temp"), "b", remove=FALSE) %>%
select(-temp) %>%
separate(hpvNum3, c("hpvNum4", "temp"), "v", remove=FALSE) %>%
select(HPV_Type = hpvNum, hpvNum = hpvNum4, hpvStatus, meanCount) %>%
mutate(hpvNum = as.integer(hpvNum)) %>%
spread(hpvStatus, meanCount) %>%
arrange(hpvNum) %>%
mutate(HPV_Type = factor(HPV_Type, as.character(HPV_Type))) %>%
mutate(riskStatus = case_when(
                              HPV_Type==16 ~ "high risk HPV",
                              HPV_Type==18 ~ "high risk HPV",
                              HPV_Type==31 ~ "high risk HPV",
                              HPV_Type==33 ~ "high risk HPV",
                              HPV_Type==35 ~ "high risk HPV",
                              HPV_Type==39 ~ "high risk HPV",
                              HPV_Type==45 ~ "high risk HPV",
                              HPV_Type==51 ~ "high risk HPV",
                              HPV_Type==52 ~ "high risk HPV",
                              HPV_Type==56 ~ "high risk HPV",
                              HPV_Type==58 ~ "high risk HPV",
                              HPV_Type==59 ~ "high risk HPV",
                              HPV_Type=="68a" ~ "high risk HPV",
                              HPV_Type=="68b" ~ "high risk HPV",
                              TRUE ~ "low risk HPV")) %>%
mutate(textColor = ifelse(riskStatus == "high risk HPV", "#DF8F44FF", "#00A1D5FF")) %>%
select(HPV_Type, hpvNum, riskStatus, textColor, Cneg = neg, Bpos = pos, Amin_reads = min_reads) %>%
group_by(HPV_Type, hpvNum, riskStatus, textColor) %>%
gather(hpvStatus, meanCount, Bpos, Cneg, Amin_reads, -HPV_Type, -hpvNum, -riskStatus, -textColor)

#plot - two trend lines and log base 10 scale for y
returnPlot = ggplot(signalNoiseDf, aes(x=HPV_Type, y=meanCount, color=hpvStatus, group=hpvStatus)) +
geom_line() +
scale_y_log10(labels = comma, breaks=c(0,1,10, 100, 1000, 10000, 100000, 1e6)) +
theme_light() +
theme(
      axis.text.y = element_text(angle = 0, hjust = 1, color = "darkblue", size = 18),
      axis.text.x = element_text(angle = 90, hjust = 0, color = temp$textColor, size = 18, vjust = 0.5),
      axis.line = element_line(colour = "darkblue",  size = 2, linetype = "solid")) +
theme(strip.background = element_blank(),
      legend.position="none") +
labs(title="Signal to Noise for Current Ion Torrent Run", x= "HPV Types", y = "Average Counts", size=36) +
theme(axis.text=element_text(size=36), axis.title=element_text(size=36,face="bold")) +
theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(0.5, 0.5, 0.5, 0, "cm"),
  plot.background = element_rect(
    fill = "grey90",
    colour = "black",
    size = 1)) +
scale_color_igv()

print(returnPlot)

return(signalNoiseDf1)
}
