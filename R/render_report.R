#'
render_report <- function(
                              startPluginDf, 
                              sample_summary_out, 
                              samples_and_controles_df_out, 
                              lineage_plot1_out, 
                              lineage_plot2_out,
                              coinfection_rate_histogram
){

system('Rscript -e \'require(devtools); install_github("cgrlab/TypeSeqHPV", force=TRUE); require(TypeSeqHPV); require(rmarkdown); run_type = "not_ts"; system(paste0("cp ", system.file("extdata/ion_report", "Ion_Torrent_report.R", package = "TypeSeqHPV")," ./")); render("Ion_Torrent_report.R")\'')


}
