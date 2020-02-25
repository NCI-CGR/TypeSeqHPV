#' Run Metadata
#' The pandoc table is an output of the pluginJsonFunc function. 
#' The possibly() function will allow for failures in this step. 
#' A failure will occur if not runing on torrent sever (such as when testing).
#'


hpv_status_circle_plot <- function(df){
library(ggsci)
pieChart = df %>%

group_by(Project) %>%
do({
project_id = .$Project[1]

temp = as_tibble(.) %>%
mutate(hpv_status = case_when(Num_Types_Pos == 0 ~ "HPV_neg",
                              HPV16 == "pos" ~ "hrHPV_pos",
                              HPV18 == "pos" ~ "hrHPV_pos",
                              HPV31 == "pos" ~ "hrHPV_pos",
                              HPV33 == "pos" ~ "hrHPV_pos",
                              HPV35 == "pos" ~ "hrHPV_pos",
                              HPV39 == "pos" ~ "hrHPV_pos",
                              HPV45 == "pos" ~ "hrHPV_pos",
                              HPV51 == "pos" ~ "hrHPV_pos",
                              HPV52 == "pos" ~ "hrHPV_pos",
                              HPV56 == "pos" ~ "hrHPV_pos",
                              HPV58 == "pos" ~ "hrHPV_pos",
                              HPV59 == "pos" ~ "hrHPV_pos",
                              HPV68 == "pos" ~ "hrHPV_pos",
                             # HPV68b == "pos" ~ "hrHPV_pos",
                              TRUE ~ "lrHPV_pos")) %>%
select(Owner_Sample_ID, Num_Types_Pos, hpv_status) %>%
mutate(totalSamples = n()) %>%
group_by(hpv_status, totalSamples) %>%
mutate(statusCount = n()) %>%
mutate(percentage = round(((statusCount / totalSamples) * 100), digits=0)) %>%
ungroup() %>%
arrange(hpv_status, Owner_Sample_ID) %>%
write_csv(paste0(project_id, "_circle_plot_data.csv"))

circlePlot = ggplot(temp %>% select(hpv_status, percentage) %>% distinct(), aes(x=1, y=percentage, fill=hpv_status)) +
geom_bar(stat="identity") +
geom_text(aes(label = paste0(percentage, "%")), size=5, position = position_stack(vjust = 0.5))  +
coord_polar(theta="y") +
theme_light() +
theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank()) +

theme(strip.background = element_blank(),
      legend.direction="vertical") +
labs(title=project_id, y= "", x = "") +
theme(
  panel.background = element_rect(fill = "white"),
  plot.margin = margin(0.5, 0.2, 0.5, 0, "cm"),
  plot.background = element_rect(
    fill = "grey90",
    colour = "black",
    size = 1
)) +
scale_fill_jama(alpha=0.8)

print(circlePlot)

temp = temp

})
}
