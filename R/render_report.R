#'
render_ion_qc_report <- function(...){

require(knitr)
require(rmarkdown)  
require(TypeSeqHPV)
require(scales)
require(ggsci)
require(pander)
  
render(input=system.file("reports", "Ion_Torrent_report.R", 
                         package = "TypeSeqHPV"), 
       output_dir="./", output_file="Ion_Torrent_report.pdf")

}
