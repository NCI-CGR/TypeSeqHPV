#'
render_ion_qc_report <- function(...){

require(dplyr)
require(knitr)
require(rmarkdown)  
require(TypeSeqHPV)
require(scales)
require(ggsci)
library(pander)
  
render(input=system.file("reports", "Ion_Torrent_report.R", 
                         package = "TypeSeqHPV"), 
       output_dir="./", output_file="TypeSeqHPV_QC_report.pdf")

system(paste0("cp Ion_Torrent_report.pdf ", final_pn_matrix$Assay_Batch_Code[1], "_qc_report.pdf"))

system("zip -j TypeSeqHPV_Report_Files.zip *csv *qc_report.pdf")

temp = data_frame(path = "Ion_Torrent_report.pdf")

}
