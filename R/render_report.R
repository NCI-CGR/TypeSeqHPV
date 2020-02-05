#'
render_ion_qc_report <- function(args_start_plugin,
                                 control_for_report,
                                 samples_only_for_report,
                                 control_results,
                                 read_count_matrix_report,
                                 detailed_pn_matrix_for_report,
                                 pn_filters,
                                 lineage_for_report){

require(dplyr)
require(knitr)
require(rmarkdown)
#require(TypeSeqHPV)
require(scales)
require(ggsci)
library(pander)

# system(paste0("cp ",
#               system.file(
#                   "reports", "Ion_Torrent_report.R", package = "TypeSeqHPV"),
#               " ./"))

system("cp /TypeSeqHPV/inst/typeseq2/Ion_Torrent_report.R ./")

render(input = "Ion_Torrent_report.R",
       output_dir = "./", output_file = "TypeSeqHPV_QC_report.pdf")

return(data_frame(path = "Ion_Torrent_report.pdf"))

}
