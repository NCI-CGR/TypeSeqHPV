#' **Get Args**
#'   
#' args.R is dynamically created by the common workflow language (cwl) javascript evaluator. 
#' We use args.R here instead a command line args approach.

ion_report_get_args <- function(is_test){
# get args
# this part is for interactive testing only

source("args.R")
system("cat args.R")
}
