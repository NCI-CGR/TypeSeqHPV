#'
coinfection_rate_histogram <- function(df){

coinfectionRateHistrogramDf = df %>%
filter(!is.na(Project)) %>%
group_by(Project) %>%
do({

project_id = .$Project[1]

temp = as_tibble(.) %>%
group_by(Num_Types_Pos) %>%
summarize(count = n())

coinfectionRateHistogram = ggplot(temp, aes(Num_Types_Pos, count)) +
geom_bar(stat="identity", fill="#DF8F44FF") +
theme_light() +
theme(
      axis.text.y = element_text(angle = 0, hjust = 1, color = "darkblue", size = 10),
      axis.text.x = element_text(hjust = 0.5),
      axis.line = element_line(colour = "darkblue",  size = 2, linetype = "solid")) +
theme(strip.background = element_blank(),
      legend.position="none") +
labs(title=paste0("Coinfection Rate for Project -- ", project_id), x= "Unique HPV Types Detected", y = "Number of Samples") +
theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(0.5, 0.5, 0.5, 0, "cm"),
  plot.background = element_rect(
    fill = "grey90",
    colour = "black",
    size = 1)) +
scale_x_continuous(breaks=c(0:max(df$Num_Types_Pos))) +
geom_text(aes(label=count, hjust = 0.5, vjust=-0.25, size=2.75)) +
geom_text(aes(y=count * 1.1, label="")) 

print(coinfectionRateHistogram)

temp = temp

}) %>%
write_csv("coinfection_rate_histogram_plot_data.csv")

return(coinfectionRateHistrogramDf)
}
