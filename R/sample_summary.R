#' **Sample Results Summary**
#'  
#' The possibly() function guards against failure for all of the figures. 
#' It is better to have the report be generated and troubleshoot later why the figure was absent 
#'then to have the plugin fail at these steps.

sample_summary <- function(df){

sampleSummary = df %>%
group_by(Project) %>%
mutate(numSamplesTested = n()) %>%
group_by(Project, numSamplesTested, Human_Control) %>%
summarize(count = n()) %>%
ungroup() %>%
spread(Human_Control, count, fill=0) %>%
select(Project_ID = Project, `Number Samples Tested` = numSamplesTested,
       `Number Passed` = pass, `Number Failed` = failed_to_amplify) %>%
arrange(Project_ID) %>%
mutate(`Perc Passed` = paste0(round(`Number Passed`/`Number Samples Tested` * 100, digits=2), "%"))  %>%
mutate(`Perc Failed` = paste0(round(`Number Failed`/`Number Samples Tested` * 100, digits=2), "%"))

pandoc.table(as_tibble(sampleSummary), style = "multiline", justify=c("right", "left", "left", "left", "left", "left"),  caption = "SAMPLE Summary", use.hyphening=TRUE, split.cells=30)

}
