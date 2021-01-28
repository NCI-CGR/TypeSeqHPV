#' Read In Parameters
#' The parameters dataframe is read in from a csv file input.

read_in_parameters_csv = function(parameter_file_path){
parameters_df = read_tsv(parameter_file_path) %>% 
map_if(is.factor, as.character) %>% 
as_tibble() %>%
glimpse()
}
