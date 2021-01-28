# load R packages ----
require(tidyverse)
require(fs)
library(scales)
library(ggsci)
library(magrittr)

# Line Plot ----

HR_positive = read_csv("T43_Signal-to-Noise-HR_POS.csv") %>%
    mutate(hpvStatus = "pos") %>%
    gather(HPV_Type, HPV_Type_count, -hpvStatus) %>%
    filter(!is.na(HPV_Type_count)) %>%
    glimpse()

HR_negative = read_csv("T43_Signal-to-Noise-HR_NEG.csv") %>%
    mutate(hpvStatus = "neg") %>%
    gather(HPV_Type, HPV_Type_count, -hpvStatus) %>%
    filter(!is.na(HPV_Type_count)) %>%
    glimpse()

signalNoiseDftemp = bind_rows(HR_positive, HR_negative) %>%
    glimpse()


# merge final pn matrix and hpv_types ----
signalNoiseDf1 = signalNoiseDftemp %>%
    group_by(hpvStatus, HPV_Type) %>%
    arrange(HPV_Type_count) %>%
    mutate(posOrder = 1:n()) %>%
    arrange(desc(HPV_Type_count)) %>%
    mutate(negOrder = 1:n()) %>%
    ungroup() %>%
    glimpse()

# signalNoiseDf ----
signalNoiseDf = signalNoiseDf1 %>%
    mutate(plotOrder = ifelse(hpvStatus == "pos", posOrder, negOrder)) %>%
    select(HPV_Type, hpvStatus, HPV_Type_count, plotOrder) %>%
    # select top 10 lowest count positives and 5 highest negatives ()
    #filter(plotOrder <= 10) %>%
    group_by(HPV_Type, hpvStatus) %>%
    # find mean!
    summarize(meanCount = mean(HPV_Type_count)) %>%
    ungroup() %>%
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
    select(HPV_Type, hpvNum, riskStatus, textColor, Cneg = neg, Bpos = pos) %>%
    group_by(HPV_Type, hpvNum, riskStatus, textColor) %>%
    gather(hpvStatus, meanCount, Bpos, Cneg, -HPV_Type, -hpvNum, -riskStatus, -textColor) %>%
    mutate(mean_count = as.integer(meanCount))

#plot - two trend lines and log base 10 scale for y ----
returnPlot = ggplot(signalNoiseDf, aes(x = HPV_Type, y = meanCount, color=hpvStatus, group=hpvStatus)) +
    geom_line() +
    scale_y_log10(labels = comma, breaks=c(0,1,10, 100, 1000, 10000, 100000, 1e6)) +
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
            size = 1)) +
    scale_color_igv()

print(returnPlot)

ggsave("v2_s2n.png", device = "png", dpi = 500, width = 11,
       height = 8.5)



# Look at box plots ----

HR_positive = read_csv("T43_Signal-to-Noise-HR_POS.csv") %>%
    mutate(hpvStatus = "positive") %>%
    gather(HPV_Type, read_counts, -hpvStatus) %>%
    filter(!is.na(read_counts)) %>%
    glimpse()

HR_negative = read_csv("T43_Signal-to-Noise-HR_NEG.csv") %>%
    mutate(hpvStatus = "negative") %>%
    gather(HPV_Type, read_counts, -hpvStatus) %>%
    filter(!is.na(read_counts)) %>%
    glimpse()




# Combine ----
# Make a single tidy comibned table called read_counts


read_counts = bind_rows(HR_positive, HR_negative) %>%
    rename(hpv_type = HPV_Type, status = hpvStatus) %>%
    arrange(desc(read_counts)) %>%
    mutate(hpv_num = str_sub(hpv_type, 4)) %>%
    mutate(hpv_num = ifelse(hpv_num == "72a", "72",hpv_num)) %>%
    mutate(hpv_num = ifelse(hpv_num == "64", "34", hpv_num)) %>%
    filter(hpv_num != "55") %>%
    mutate(hpv_order = hpv_num) %>%
    mutate(hpv_order = ifelse(hpv_order == "68a", "68.1", hpv_order)) %>%
    mutate(hpv_order = ifelse(hpv_order == "68b", "68.5", hpv_order)) %>%
    mutate(hpv_order = ifelse(hpv_order == "82v", "82.5", hpv_order)) %>%
    mutate(hpv_order = as.integer(hpv_order)) %>%
    mutate(hpv_num = factor(hpv_num, levels =
                                unique(hpv_num[order(hpv_order)]))) %>%
    arrange(hpv_num) %>%
    glimpse() %>%
    filter(read_counts > 0) %>%
    glimpse()


# Make box plots ----


(box_plot = read_counts %>%
    ggplot(aes(hpv_num,
               read_counts,
               fill = status)) +
    geom_boxplot(outlier.color = NULL, outlier.alpha = 0.2) +
    #geom_boxplot(outlier.color = NULL, outlier.size = 0.7, outlier.alpha = 0.2) +
    #geom_boxplot(outlier.color = NULL) +
    scale_y_log10(breaks = c(0,1,10,100,1000,10000, 200000), labels = number) +
    ylab("Sequencing Read Counts (log10)") +
    theme(axis.title.y = element_text(face = "bold.italic", size=20)) +
    theme(axis.title.x = element_text(face = "bold.italic", vjust = -5, size=20)) +
    xlab("HPV Genotype") +
    theme(aspect.ratio = 9/25) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size=20)) +
    theme(axis.text.y = element_text(size=20)) +

    scale_fill_manual(values = c("orange", "#5665B5"),
                      name = "Status", guide = guide_legend(reverse = TRUE)) +
    theme(legend.position = "right"))


    ggsave("box_plot.png", plot = box_plot, device = "png",
       dpi = 500, width = 18,
       height = 8.5)




