# Databricks notebook source
# load packages

if (!exists("is_batch")) {library(SparkR)}

dynamic_require = function(x){
  for( i in x ){
    #  require returns TRUE invisibly if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      install.packages( i , dependencies = TRUE )
      #  Load package after installing
      require( i , character.only = TRUE )
    }
  }
}

dynamic_require(c("tidyverse",
                  "jsonlite"))

dynamic_require_bioc = function(x){
  for( i in x ){
    #  require returns TRUE invisibly if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      source("https://bioconductor.org/biocLite.R")
      biocLite(i)
      install.packages( i , dependencies = TRUE )
      #  Load package after installing
      require( i , character.only = TRUE )
    }
  }
}

dynamic_require_bioc("GenomicAlignments")

sessionInfo()


# COMMAND ----------

if (!exists("is_batch")) {

system("rm -r /databricks/driver/TypeSeqerHpvIon") 
system("mkdir /databricks/driver/TypeSeqerHpvIon")
setwd("/databricks/driver/TypeSeqerHpvIon")  
  
args_create_lineage_table_output = "true" 

args_bam_json = data_frame(path = "/databricks/driver/TypeSeqerHpvIon/IX68_200k.json", name = "IonXpress_068_rawlib.filtered.json") 

args_A_barcode = "A68" 

args_lineage_reference_path="/dbfs/FileStore/projects/RD111_TypeSeqer/lineage_test/20180121_lineage_reference_table_and_filters_2.csv"

args_barcode_list = "/dbfs/FileStore/projects/RD111_TypeSeqer/lineage_test/barcodeList_v1.csv" 

args_parameter_file = data_frame(path = "/dbfs/FileStore/projects/RD111_TypeSeqer/lineage_test/hpv_types_MQ_min_max_len_filters_JUNE2017_30-10bpLen_v6.txt")
  
system("touch args.R")
  
#create a smaller version of the raw reads bam json

system("head -n 200000 /dbfs/FileStore/projects/RD111_TypeSeqer/lineage_test/IonXpress_068_rawlib.filtered.json > /databricks/driver/TypeSeqerHpvIon/IX68_200k.json")

}

# COMMAND ----------

read_lines("args.R") %>% 
writeLines()
source("args.R")

# COMMAND ----------

# MAGIC %md
# MAGIC 
# MAGIC ##Below are 2 functions used in this read processor app.
# MAGIC 
# MAGIC * Read Metrics  
# MAGIC * Barcode 2 demultiplex (includes lineage detectin inside this function)

# COMMAND ----------

# here are 3 funcions that are used in this run processor app
ts_read_metrics = function(bam_json_input, parameters_df_input){

# only used in a jsonlite streaming function

if("ZA" %in% colnames(bam_json_input$tags)){ ZA_df = data_frame(ZA = bam_json_input$tags$ZA)}else{ZA_df = data_frame(ZA = rep(0, length(bam_json_input$qname)))}

bam_json = bam_json_input %>%
select(qname, HPV_Type = rname, seq, mapq, cigar) %>%
mutate(page_num = page) %>%
bind_cols(ZA_df) %>%
mutate(ZA = ifelse(is.na(ZA), 0, ZA)) %>%
mutate(bc1_id = args_A_barcode) %>%
mutate(file_name = args_bam_json$name) %>%
mutate(total_reads = n()) %>%
  
# left join with parameters file that contians qualifying criteria for each hpv contig
left_join(parameters_df_input) %>%
  
# mapq greater than 0 - count multi-mapped / 0 mapping quaity and filter becuase cigar will be 0 so we cannot include past here
mutate(mapq_greater_than_zero = ifelse(mapq != 0, 1, 0)) %>%
mutate(mapq_greater_than_zero = sum(mapq_greater_than_zero)) %>%
filter(mapq > 0) %>%
  
# ZA
mutate(pass_za = ifelse(str_length(seq) == ZA, 1, 0)) %>%
  
# aligned length within specific parameters
mutate(cigar_seq = as.character(sequenceLayer(DNAStringSet(seq), cigar))) %>%
mutate(cigar_len = str_length(cigar_seq)) %>%
mutate(pass_seq_length = ifelse(
  cigar_len >= min_len, ifelse(
  cigar_len <= max_len, ifelse(
  pass_za == 1, 1, 0), 0), 0)) %>%
  
# mapq is greater than specific parameters
mutate(pass_mapq = ifelse(mapq >= min_mq, 1, 0)) %>%

mutate(pass_mapq = ifelse(
  mapq >= min_mq, ifelse(
  pass_seq_length == 1, ifelse(
  pass_za == 1, 1, 0), 0), 0)) %>%

# sum up
mutate(pass_za = sum(pass_za)) %>%
mutate(pass_seq_length = sum(pass_seq_length)) %>%
mutate(pass_mapq = sum(pass_mapq)) %>%
# select the final colums and compress down to 1 row with distinct()
select(page_num, bc1_id, total_reads, mapq_greater_than_zero, pass_za, pass_seq_length, pass_mapq, file_name) %>%
distinct()
  
    
}

# COMMAND ----------

ts_demultiplex_bc2 = function(bam_json_input, parameters_df_input, barcode_list_input){

if("ZA" %in% colnames(bam_json_input$tags)){ ZA_df = data_frame(ZA = bam_json_input$tags$ZA)}else{ZA_df = data_frame(ZA = rep(0, length(bam_json_input$qname)))}

bam_json = bam_json_input %>%
select(qname, HPV_Type = rname, seq, mapq, cigar) %>%
mutate(page_num = page) %>%
bind_cols(ZA_df) %>%
mutate(ZA = ifelse(is.na(ZA), 0, ZA)) %>%
mutate(bc1_id = args_A_barcode) %>%
mutate(file_name = args_bam_json$name) %>%
mutate(total_reads = n()) %>%
mutate(seq_length = str_length(seq)) %>%
left_join(parameters_df) %>%

# Filter 1 - mapq > 0 ----
filter(mapq > 0) %>%
  
# Filter 2 - ZA  ----
filter(str_length(seq) == ZA) %>%

# Filter 3 - aligned length within specific parameters ----
mutate(cigar_seq = as.character(sequenceLayer(DNAStringSet(seq), cigar))) %>%
mutate(cigar_len = str_length(cigar_seq)) %>%
filter(cigar_len >= min_len & cigar_len <= max_len) %>%

# Filter 4 - mapq is greater than specific parameters ----
filter(mapq >= min_mq)

 # filter 5 - barcode is perfect match ----

bam_json_with_barcode = barcode_list %>%
select(bc2_id = id, bc_sequence = sequence, bc_adapter = adapter) %>%
filter(str_sub(bc2_id, end =1) == "P") %>%
mutate(bc_length = str_length(bc_sequence)) %>%
group_by(bc2_id, bc_sequence) %>%
do({
bc_length = .$bc_length
bc_sequence = .$bc_sequence

bam_json_temp = bam_json %>%
mutate(three_prime_seq = str_sub(seq, start = -(bc_length))) %>%
filter(three_prime_seq == bc_sequence)

}) %>%
ungroup() %>%
mutate(qualified_barcode_reads = n()) %>%
group_by(file_name, bc1_id, bc2_id, HPV_Type) %>%
mutate(HPV_Type_count = n()) %>%
ungroup()

### lineage for 2017 ###
lineage_output = bam_json_with_barcode %>%
select(bc1_id, bc2_id, qname, HPV_Type, mapq, cigar_seq, HPV_Type_count) %>%
inner_join(lineage_reference_table, by = "HPV_Type") %>%
mutate(lineage_tag = "No value") %>% 
mutate(lineage_tag = ifelse(str_sub(cigar_seq, Base_num, Base_num) == Base_ID,
                            paste0(HPV_Type,"_", Lineage_ID), "undetermined")) %>%
group_by(qname, HPV_Type, Lineage_ID) %>%
mutate(lineage_tag = paste(lineage_tag, collapse = ",")) %>%
ungroup() %>%
select(bc1_id, bc2_id,qname, HPV_Type, Lineage_ID, lineage_tag, cigar_seq, mapq, HPV_Type_count) %>%
distinct() %>%
mutate(total_reads = n()) %>%
mutate(lineage_tag = ifelse(str_detect(lineage_tag, "undetermined"), "undetermined", "full match")) %>%
group_by(bc1_id, bc2_id, HPV_Type, Lineage_ID, lineage_tag) %>% 
mutate(lineage_read_count = n()) %>%
ungroup() %>%
mutate(page_num = page) %>%
select(bc1_id, bc2_id, page_num, HPV_Type, Lineage_ID, lineage_tag, lineage_read_count, HPV_Type_count) %>%
distinct()
####   
  
#### finish the bc2 demultiplex df ####
hpv_types_output = bam_json_with_barcode %>%  
select(file_name, page_num, bc1_id, bc2_id, qualified_barcode_reads, HPV_Type, HPV_Type_count, display_order) %>%
distinct()
  
### make a list output ###
output = list(hpv_types_output = hpv_types_output, lineage_output = lineage_output)

}

# COMMAND ----------

parameters_df = read_tsv(args_parameter_file$path) %>% 
map_if(is.factor, as.character) %>% 
as_tibble() %>% 
mutate(min_mq = mq) %>% 
select(-mq)

lineage_reference_table = read_csv(args_lineage_reference_path) %>%
map_if(is.factor, as.character) %>% 
as_tibble() %>% 
glimpse()

barcode_list = read_csv(args_barcode_list)
page = 1

# COMMAND ----------

read_metrics_output = file(paste0(args_bam_json$name,"_read_metrics.json"), open = "wb")
bc2_demultiplex_output = file(paste0(args_bam_json$name,"_bc2_demultiplex.json"), open = "wb")
lineage_output = file(paste0(args_bam_json$name,"_hpv_lineage.json"),open = "wb")

stream_in(file(args_bam_json$path), handler = function(df){

read_metrics_df = df %>% 
ts_read_metrics(parameters_df)
  

bc2_demultiplex_df = df %>% 
ts_demultiplex_bc2(parameters_df, barcode_list)

stream_out(read_metrics_df, read_metrics_output, verbose = TRUE) 
  
stream_out(bc2_demultiplex_df$hpv_types_output, bc2_demultiplex_output, verbose = TRUE) 
  
stream_out(bc2_demultiplex_df$lineage_output, lineage_output, verbose = TRUE) 
  
page <<- page + 1

}, pagesize = 10000, verbose = FALSE)

close(read_metrics_output)
close(bc2_demultiplex_output)
close(lineage_output)
