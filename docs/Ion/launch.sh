#!/bin/bash
set -x
# TypeSeq HPV Plugin
VERSION="1.18.07.1303"
#autorundisable
echo Pipeline version $VERSION

ln ../../*.bam ./
cp  ${DIRNAME}/*.csv ./
cp  ${DIRNAME}/*.txt ./

FILES=`ls *.bam`

/results/plugins/scratch/rabix/rabix -b ./  ${DIRNAME}/TypeSeqHPV_ion_torrent_workflow.cwl -- \
--input `echo $FILES | sed 's/ / --input /g'` \
--mem_mb 8000 \
--parameter_file hpv_types_MQ_min_max_len_filters_JUNE2017_30-10bpLen_v6.txt \
--pos_neg_filtering_criteria_path 2017-06-11_Pos-Neg_matrix_filtering_criteria_RefTable_v3.txt \
--run_manifest startplugin.json \
--control_definitions startplugin.json \
--report_grouping startplugin.json \
--scaling_table 2017-11-24_TypeSeqer_Filtering_Scaling_Table_v2.csv \
--barcode_list barcodeList_TypingV1_v2-barcodes.csv \
--lineage_reference_table 20180121_lineage_reference_table_and_filters_2.csv \
--is_torrent_server | true

rm *.bam | true
rm */root/*/*/*filtered.json | true
rm */root/*/*/*random.json | true
rm */root/select_first_file_in_array/*.bam | true

cp */*/ion_typeseqer_report/hpv_typing_html.html ./TypeSeqer_hpv_plugin_block.html

cp */*/ion_typeseqer_report/Ion_Torrent_report.pdf ./TypeSeqer_QC_report.pdf

zip -j TypeSeqer_Report_Files.zip */*/ion_typeseqer_report/*csv */*/ion_typeseqer_report/*report.pdf

