#'
render_report <- function(startPluginDf, 
                              sample_summary_out, 
                              samples_and_controles_df_out, 
                              lineage_plot1_out, 
                              lineage_plot2_out,
                              coinfection_rate_histogram,
                              split_deliverables
){

render(input=system.file("extdata/ion_report", "Ion_Torrent_report.R", 
                         package = "TypeSeqHPV"), 
       output_dir="./", output_file="Ion_Torrent_report.pdf")

}
