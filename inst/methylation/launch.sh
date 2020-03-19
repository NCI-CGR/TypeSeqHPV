#!/bin/bash
set -x
# TypeSeq HPV Methyl
VERSION="1.1903.1901"
#autorundisable
echo Pipeline version $VERSION

ln ../../*.bam ./

docker run -i -v $(pwd):/mnt -v /mnt:/user_files \
    cgrlab/typeseqhpv:development_191226 \
        Rscript /TypeSeqHPV/workflows/ion_methyl_workflow.R \
        --is_torrent_server yes \
        --config_file config_file.csv \
        --barcode_file barcodes.csv \
        --control_definitions control_defs.csv \
        --control_freq control_freq.csv \
        --cores 22 \
        --hotspot_vcf TS2-T52_v1-HOTSPOT.hotspot.vcf \
        --manifest manifest.csv \
        --ram 80G \
        --reference reference.fasta \
        --region_bed region.bed \
        --tvc_cores 4 \
        --tvc_parameters local_parameters.json

rm *rawlib.bam
