#!/bin/bash
set -x
# TypeSeq HPV Plugin
VERSION="2.1808.2701"
#autorundisable
echo Pipeline version $VERSION

ln ../../*.bam ./

docker run -i -v $(pwd):/mnt cgrlab/typeseqhpv:final_18082401 Rscript /TypeSeqHPV/workflows/ion_workflow.R \
--pos_neg_filtering_criteria /TypeSeqHPV/docs/Ion/2017-06-11_Pos-Neg_matrix_filtering_criteria_RefTable_v3.txt \
--scaling_table /TypeSeqHPV/docs/Ion/2017-11-24_TypeSeqer_Filtering_Scaling_Table_v2.csv \
--parameter_file /TypeSeqHPV/docs/Ion/hpv_types_MQ_min_max_len_filters_JUNE2017_30-10bpLen_v6.txt \
--lineage_reference /TypeSeqHPV/docs/Ion/20180121_lineage_reference_table_and_filters_2.csv \
--barcode_list /TypeSeqHPV/docs/Ion/barcodeList_v1.txt \
--bam_files_dir /mnt/ \
--start_plugin /mnt/startplugin.json \
--custom_groups /mnt/report_grouping.csv \
--control_defs /mnt/control_defs.csv \
--run_manifest /mnt/typing_manifest.csv \
--is_torrent_server "yes"

#rm extra bam and bam.json files
rm *.bam*



