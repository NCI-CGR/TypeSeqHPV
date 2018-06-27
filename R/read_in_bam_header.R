#'
read_in_bam_header <- function(bam_header_path){
bam_header = read_tsv(bam_header_path, col_names = c("header_col1", "HPV_Type","contig_size")) %>%
filter(header_col1 == "@SQ") %>%
mutate(HPV_Type = str_sub(HPV_Type, start=4)) %>%
select(HPV_Type)
}
