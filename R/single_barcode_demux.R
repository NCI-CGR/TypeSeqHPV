single_barcode_demux<- function(demux_bam){
    
#system(paste0("samtools sort ", demux_bam$bam_path, " ", demux_bam$sample, "_sorted"), wait = TRUE)
system(paste0("samtools index ", demux_bam$sorted_path))
    
           
}