#'
percent_positive_histogram <- function(df){

percentPositveHistrogramDf = df %>%
group_by(Project) %>%
do({

project_id = .$Project[1]

temp = as_tibble(.) %>%
do({
temp = .

df = temp %>%
  summarize(sampleCount = n())

temp = temp %>%
  mutate(sampleCount = df$sampleCount)

}) %>%
gather(hpvType, hpvStatus, starts_with("HPV")) %>%
filter(hpvStatus == "pos") %>%
group_by(hpvType, sampleCount) %>%
summarize(posCount = n()) %>%
mutate(percPos = posCount / sampleCount) %>%
ungroup() %>%
full_join(bam_header %>% select(hpvType = HPV_Type) %>%
                         filter(!(hpvType %in% c("HPV34",
                                                 "HPV54_B_C_consensus",
                                                 "HPV74_EU911625", "HPV74_EU911664", "HPV74_U40822", "B2M")))) %>%
mutate(posCount = ifelse(is.na(posCount), 0, posCount)) %>%
mutate(percPos = ifelse(is.na(percPos), 0, percPos)) %>%
separate(hpvType, c("temp", "hpvNum"), "HPV", remove=FALSE) %>%
select(-temp) %>%
separate(hpvNum, c("hpvNum2", "temp"), "a", remove=FALSE) %>%
select(-temp) %>%
separate(hpvNum2, c("hpvNum3", "temp"), "b", remove=FALSE) %>%
select(-temp) %>%
separate(hpvNum3, c("hpvNum4", "temp"), "v", remove=FALSE) %>%
select(hpvType = hpvNum, hpvNum = hpvNum4, posCount, percPos, sampleCount) %>%
mutate(hpvNum = as.integer(hpvNum)) %>%
arrange(hpvNum) %>%
mutate(hpvType = factor(hpvType, as.character(hpvType))) %>%
mutate(riskStatus = case_when(
                              hpvType==16 ~ "high risk HPV",
                              hpvType==18 ~ "high risk HPV",
                              hpvType==31 ~ "high risk HPV",
                              hpvType==33 ~ "high risk HPV",
                              hpvType==35 ~ "high risk HPV",
                              hpvType==39 ~ "high risk HPV",
                              hpvType==45 ~ "high risk HPV",
                              hpvType==51 ~ "high risk HPV",
                              hpvType==52 ~ "high risk HPV",
                              hpvType==56 ~ "high risk HPV",
                              hpvType==58 ~ "high risk HPV",
                              hpvType==59 ~ "high risk HPV",
                              hpvType=="68a" ~ "high risk HPV",
                              hpvType=="68b" ~ "high risk HPV",
                              TRUE ~ "low risk HPV")) %>%
mutate(textColor = ifelse(riskStatus == "high risk HPV", "#DF8F44FF", "#00A1D5FF"))

plotCount = ggplot(temp, aes(hpvType, posCount, fill=factor(riskStatus))) +
geom_bar(stat = "identity") +
theme_light() +
theme(
      axis.text.y = element_text(angle = 0, hjust = 1, color = "darkblue", size = 10),
      axis.text.x = element_text(angle = 90, hjust = 0, color = temp$textColor, size = 9, vjust = 0.5),
      axis.line = element_line(colour = "darkblue",  size = 2, linetype = "solid")) +
theme(strip.background = element_blank(),
      legend.position="none") +
labs(title=paste0("Number of Samples Positive by Type for Project -- ", project_id), x= "hpv type", y = "sample count") +
theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(0.5, 0.5, 0.5, 0, "cm"),
  plot.background = element_rect(
    fill = "grey90",
    colour = "black",
    size = 1
  )
) +
scale_y_continuous(breaks= pretty_breaks()) +
geom_text(aes(label=posCount), hjust = 0.5, vjust=-0.25, size=2.75) +
geom_text(aes(y=posCount * 1.1, label="")) +
scale_fill_manual(values=pal_jama(alpha = 0.8)(9)[2:9]) +
theme(legend.title=element_blank())

plotPercent = ggplot(temp, aes(hpvType, percPos, fill=factor(riskStatus))) +
geom_bar(stat = "identity") +
theme_light() +
theme(
      axis.text.y = element_text(angle = 0, hjust = 1, color = "darkblue", size = 10),
      axis.text.x = element_text(angle = 90, hjust = 0, color = temp$textColor, size = 9, vjust = 0.5),
      axis.line = element_line(colour = "darkblue",  size = 2, linetype = "solid")) +
theme(strip.background = element_blank(),
      legend.position="none") +
labs(title=paste0("Percent of Samples Positive by Type for Project -- ", project_id), x= "hpv type", y = "percent positive") +
theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(0.5, 0.5, 0.5, 0, "cm"),
  plot.background = element_rect(
    fill = "grey90",
    colour = "black",
    size = 1)) +
scale_y_continuous(labels = scales::percent) +
scale_fill_manual(values=pal_jama(alpha = 0.8)(9)[2:9]) +
geom_text(aes(label=round(100* percPos, digits=1)), hjust = 0.5, vjust=-0.25, size=2.75) +
geom_text(aes(y=percPos * 1.1, label="")) +
theme(legend.title=element_blank())

print(plotCount)
print(plotPercent)

temp = temp

}) %>%
write_csv("types_positive_histogram_plot_data.csv")
}
