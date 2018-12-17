#!/bin/bash
set -x
# TypeSeq HPV Methyl
VERSION="1.1812.1201"
#autorundisable
echo Pipeline version $VERSION

ln ../../*.bam ./

docker run -i -v $(pwd):/mnt -v /mnt:/user_files \
    cgrlab/typeseqhpv:final_18121101 \
        Rscript /TypeSeqHPV/workflows/ion_methyl_workflow.R \
        --is_torrent_server yes \
        --start_plugin startplugin.json \
        --manifest manifest.csv \
        --barcode_file barcodes.csv \
        --config_file config_file.csv \
        --hotspot_vcf /path/to/hotspot_vcf.ext \
        --tvc_parameters /path/to/parameters_file.ext \
        --reference /path/to/reference.ext \
        --region_bed /path/to/region_bed.ext

rm *rawlib.bam
