#!/bin/bash
set -x
# TypeSeq HPV Methyl
VERSION="1.1811.1305"
#autorundisable
echo Pipeline version $VERSION

ln ../../*.bam ./

docker run -i -v $(pwd):/mnt \
    -v /data/TypeSeqHPV:/plugin \
    -v /data/TypeSeqHPV/input/methyl_test/new_inputs/plugin_try:/user_files \
    cgrlab/typeseqhpv:final_18120601 \
    Rscript /plugin/workflows/ion_methyl_workflow.R \
     --start_plugin /mnt/startplugin.json \
     --is_torrent_server "no"

rm *rawlib.bam
