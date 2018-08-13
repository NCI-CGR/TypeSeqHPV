#'

ion_read_processor <- function(bam_json_path, args_lineage_reference_path, args_barcode_list, parameters_df){
 require(jsonlite)


 
lineage_reference_table = read_csv(args_lineage_reference_path) %>%
map_if(is.factor, as.character) %>% 
as_tibble() 
 
barcode_list = read_csv(args_barcode_list)
 
page = 1
 
read_metrics_output = file(paste0(bam_json_path$path[1],"_read_metrics.json"), open = "wb")
bc2_demultiplex_output = file(paste0(bam_json_path$path[1],"_bc2_demultiplex.json"), open = "wb")
lineage_output = file(paste0(bam_json_path$path[1],"_hpv_lineage.json"),open = "wb")
  
 
stream_in(file(bam_json_path$path), handler = function(df){
 
  print("mark")

 
read_metrics_df = df %>% 
ts_read_metrics(parameters_df, page, bam_json_path$path)
 
 
 
print(bam_json_path$path)

bc2_demultiplex_df = df %>% 
ts_demultiplex_bc2(parameters_df, barcode_list, page, lineage_reference_table, bam_json_path$path)

stream_out(read_metrics_df, read_metrics_output, verbose = TRUE) 
  
stream_out(bc2_demultiplex_df$hpv_types_output, bc2_demultiplex_output, verbose = TRUE) 
  
stream_out(bc2_demultiplex_df$lineage_output, lineage_output, verbose = TRUE) 
  
page <<- page + 1

}, pagesize = 10000, verbose = TRUE)
  
close(read_metrics_output)
close(bc2_demultiplex_output)
close(lineage_output)
 
return(bam_json_path$path)  
  
}
