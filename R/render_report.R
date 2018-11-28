#'
render_ion_qc_report <- function(args_start_plugin,
                                 split_deliverables,
                                 samples_and_controls_df_out,
                                 control_results,
                                 hpv_types_df,
                                 final_pn_matrix,
                                 scaling_list,
                                 lineage_df,
                                 bam_header_df){

require(dplyr)
require(knitr)
require(rmarkdown)
require(TypeSeqHPV)
require(scales)
require(ggsci)
library(pander)

# system(paste0("cp ",
#               system.file(
#                   "reports", "Ion_Torrent_report.R", package = "TypeSeqHPV"),
#               " ./"))

system("cp /package/inst/reports/Ion_Torrent_report.R ./")

#system("cp ~/TypeSeqHPV/inst/reports/Ion_Torrent_report.R ./")

render(input = "Ion_Torrent_report.R",
       output_dir = "./", output_file = "TypeSeqHPV_QC_report.pdf")

system(paste0("cp TypeSeqHPV_QC_report.pdf ",
              final_pn_matrix$Assay_Batch_Code[1],
              "_qc_report.pdf"))

system("zip -j TypeSeqHPV_Report_Files.zip *csv *qc_report.pdf")

return(data_frame(path = "Ion_Torrent_report.pdf"))

}
