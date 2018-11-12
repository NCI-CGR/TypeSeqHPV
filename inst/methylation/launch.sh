#!/bin/bash
set -x
# TypeSeq HPV Methyl
VERSION="1.1811.0801"
#autorundisable
echo Pipeline version $VERSION

#ln ../../*.bam ./
ln ../*rawlib.bam ./

# docker run -i -v $(pwd):/mnt cgrlab/typeseqhpv:final_18110801 \
#     -v /results/plugins/TypeSeqHPVMethyl-DEV:/data \
# Rscript /data/ion_methyl_workflow.R \
#     --barcode_list /data/barcodes.csv \
#     --bam_files_dir /mnt/ \
#     --start_plugin /mnt/startplugin.json \
#     --run_manifest /mnt/typing_manifest.csv \
#     --is_torrent_server "yes"
#
# rm *.bam

docker run -i -v $(pwd):/mnt \
    -v /data/TypeSeqHPV:/package \
    -v /data/TypeSeqHPV/inst/methylation:/plugin \
    cgrlab/typeseqhpv:final_18110802 \
    Rscript /plugin/ion_methyl_workflow.R \
     --start_plugin /mnt/startplugin.json \
     --is_torrent_server "yes"

rm *rawlib.bam
