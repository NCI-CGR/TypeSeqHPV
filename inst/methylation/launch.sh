#!/bin/bash
set -x
# TypeSeq HPV Methyl
VERSION="1.1810.3103"
#autorundisable
echo Pipeline version $VERSION

ln ../../*.bam ./

docker run -i -v $(pwd):/mnt \
    -v /results/plugins/TypeSeqHPVMethyl-DEV:/data \
    cgrlab/typeseqhpv:adam_18102901 \
    /bin/sh -c 'cd /mnt; /home/adam/bin/adam-shell -i /data/demux_3prime_barcode_adam.scala'

rm *.bam



