#!/bin/bash
set -x
# TypeSeq2 HPV
VERSION="2.1912.2601"
#autorundisable
echo Pipeline version $VERSION

ln ../../*.bam ./

docker run -i -v $(pwd):/mnt -v /mnt:/user_files \
    cgrlab/typeseqhpv:development_191226 \
        Rscript /TypeSeqHPV/workflows/TypeSeq2.R \
        --is_torrent_server yes \
        --config_file config_file.csv \
        --barcode_file barcodes.csv \
        --control_definitions control_defs.csv \
        --grouping_defs grouping_defs.csv \
        --cores 22 \
        --manifest manifest.csv \
        --ram 80G \
        --tvc_cores 4

rm *rawlib.bam
