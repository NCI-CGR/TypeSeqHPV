#'
control_summary <- function(df){

controlSummary = df %>%
group_by(Control_type, control_result) %>%
summarize(resultStatus = n()) %>%
ungroup() %>%
spread(control_result, resultStatus, fill=0) %>%
arrange(desc(Control_type)) %>%
select(`Control type` = Control_type, `Num Passed` = pass, `Num Failed` = fail)

pandoc.table(controlSummary, style = "multiline", justify=c("right", "left", "left"),  caption = "Control Summary", use.hyphening=TRUE, split.cells=30)
}
