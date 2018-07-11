require(TypeSeqHPV)
TypeSeqHPV::illumina_read_processor_load_packages()


require(sparklyr)

#sc <- spark_connect(method = "databricks")

config=spark_config()
Sys.setenv("SPARK_MEM" = "200G")
config$`sparklyr.shell.driver-memory` <- "200G"
config$sparklyr.cores.local <- "128"
config$spark.dynamicAllocation.enabled <- TRUE  
config$spark.shuffle.service.enabled <- TRUE
#config$spark.memory.fraction <- 0.9

sc <- spark_connect(master = "local", config = config, version = '2.3.0')


# get args

read_lines("args.R") %>% 
writeLines()
source("args.R")


barcodes = read_csv(args_barcode_file) %>% 
map_if(is.factor, as.character) %>% 
as_tibble()


parameters = read_csv(args_parameter_file) %>% 
map_if(is.factor, as.character) %>% 
as_tibble() %>% 
mutate(min_mq = mq) %>% 
select(-mq)




####### read in bam json #######
bam_input = spark_read_json(sc, name="bam_tbl", overwrite=TRUE, memory=FALSE, 
                            path=args_bam_json$path) %>%
select(qname, rname, flag, seq, mapq, cigar)  %>%
mutate(pre_demultiplex_reads = n())  %>%
sdf_repartition(128) 

sdf_register(bam_input, "bam_input")

print("bam_input complete")

#### The long read and inline barcode 
bam_unmapped_second <- tbl(sc, "bam_input") %>%
filter(flag==181) %>%
#sdf_repartition(128) %>%

####### add barcode column via fuzzy join #######
spark_apply(memory = FALSE, context=barcodes, f=function(bam, barcodes){
  require(tidyverse)
  library(fuzzyjoin)
  
  bam_return = bam %>%
  fuzzy_join(barcodes, mode = "inner", 
             by=c("seq" = "bc_sequence"), 
             match_fun = function(x, y) str_detect(str_sub(x, start=-25), fixed(y, ignore_case=TRUE))) %>%
  select(-bc_sequence)
           
  return(bam_return)}, 
             names=c('qname', 'flag','seq','mapq','cigar', 'pre_demultiplex_reads', 'rname','bc_id_2'), 
             columns=list(
                    qname = "character",
                    rname = "character",
                    seq = "character",
                    map = "integer",
                    cigar = "character",
                    pre_demultiplex_reads = "integer",
                    bc_id_2 = "character"
                   )) %>%
select(qname, bc_id_2)

sdf_register(bam_unmapped_second, "bam_unmapped_second")
  
print("bam_unmapped_second complete")

#### The long read and inline barcode 
bam_mapped_first <- tbl(sc, "bam_input") %>%
filter(flag==121) %>%
#sdf_repartition(128) %>%
  
####### add barcode column via fuzzy join #######
spark_apply(memory = FALSE, context=barcodes, f=function(bam, barcodes){
  require(tidyverse)
  library(fuzzyjoin)
  
  bam_return = bam %>%
  fuzzy_join(barcodes, mode = "inner", 
             by=c("seq" = "bc_sequence"), 
             match_fun = function(x, y) str_detect(str_sub(x, start=-25), fixed(y, ignore_case=TRUE))) %>%
  select(-bc_sequence)
 
 return(bam_return)}, 
             names=c('qname', 'rname', 'flag','seq','mapq','cigar', 'pre_demultiplex_reads','bc_id_1'), 
             columns=list(
                    qname = "character",
                    rname = "character",
                   flag="integer",
                    seq = "character",
                    map = "integer",
                    cigar = "character",
                    pre_demultiplex_reads = "integer",
                    bc_id_1 = "character" ))
               
sdf_register(bam_mapped_first, "bam_mapped_first")
  
#tbl(sc, "bam_mapped_first")

print("bam_mapped_first complete")



#### merge read 1 and read 2 information by qname
# gets here in 10mins
bam = inner_join(tbl(sc, "bam_mapped_first"), tbl(sc,"bam_unmapped_second"), by="qname") %>%
#sdf_repartition(128) %>%
mutate(barcode = paste0(bc_id_1, bc_id_2)) %>%
select(-bc_id_2, -flag) %>%
mutate(total_demultiplex_reads = n()) %>%
group_by(bc_id_1) %>% 
mutate(post_demultiplex_reads = n()) %>%
ungroup() %>%
select(barcode_1 = bc_id_1, barcode, qname, HPV_Type = rname, seq, mapq, cigar, 
       pre_demultiplex_reads, total_demultiplex_reads, post_demultiplex_reads) %>%

## joining with paramers csv #######
left_join(parameters, copy=TRUE) %>%

####### filter mapq > min mapq - always summarize by barcode #######
filter(mapq >= min_mq) %>%
mutate(mapq_reads = n()) %>%
select(-display_order, -Owner_Sample_ID, -min_mq)

sdf_register(bam, "bam")


print("bam complete")

tbl(sc, "bam")
print("bam complete tbl 1")

tbl(sc, "bam")
print("bam complete tbl 2")

tbl(sc, "bam") %>%
glimpse()
print("bam complete tbl 3")



temp <- tbl(sc, "bam")  %>%
sdf_repartition(128) %>%
  
####### filter by read length #######
spark_apply(f=function(bam){
  require(tidyverse)
  require(GenomicAlignments)

  bam_return = bam %>% 
  mutate(seq_length = str_length(seq)) %>%
  mutate(cigar_seq = as.character(sequenceLayer(DNAStringSet(seq), cigar))) %>%
  mutate(cigar_len = str_length(cigar_seq)) %>%
  filter(cigar_len >= min_align_len) %>%
  select(-seq_length, -cigar_len, -cigar_seq, -min_align_len) 
    
  return(bam_return)
}, 
names=c(
  'barcode_1', 
  'barcode',
  'qname',
  'HPV_Type',
  'seq', 
  'mapq', 
  'cigar',
  'pre_demultiplexed_reads',
 'total_demultiplex_reads', 
  'post_demultiplex_reads',
  'mapq_reads'), 
columns=list(
  barcode_1 = "character",
  barcode = "character",
  qname = "character", 
  HPV_Type = "character",
  seq = "character",
  mapq = "integer",
  cigar= "character",
  pre_demultiplexed_reads = "integer",
  total_demultiplex_reads = "integer",
  post_demultiplex_reads = "integer",
  mapq_reads = "integer"
))
  
print("temp pre register complete")
  
  
sdf_register(temp, "temp")

tbl(sc, "temp") 

print("temp complete")


bam_final <- tbl(sc, "temp") %>%
####### count final qc metrics #######
mutate(qualified_barcode_reads = n()) %>%

####### count hpv type read counts #######
group_by(barcode, HPV_Type) %>%
mutate(HPV_Type_count = n()) %>%
ungroup() %>%

##### create final table for outputs #####
select(barcode_1, barcode, pre_demultiplexed_reads, total_demultiplex_reads, 
       post_demultiplex_reads, mapq_reads, qualified_barcode_reads, 
       HPV_Type, HPV_Type_count) %>%
#sdf_repartition(32) %>%
summarize()

sdf_register(bam_final, "bam_final")


tbl(sc, "bam_final") 

print("bam_final complete")



#write csv output
bam_output = tbl(sc, "bam_final") %>%
collect() %>%
distinct() %>%
#glimpse() %>%
write_csv("illum_typeseqhpv_processed_run.csv")

