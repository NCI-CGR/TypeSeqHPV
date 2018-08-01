#'
render_report <- function(...){

require(knitr);
require(rmarkdown)  
  
render(input=system.file("extdata/ion_report", "Ion_Torrent_report.R", 
                         package = "TypeSeqHPV"), 
       output_dir="./", output_file="Ion_Torrent_report.pdf")

}
