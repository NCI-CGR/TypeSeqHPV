#!/bin/bash
set -x
# TypeSeq HPV Plugin
VERSION="1.18.08.0601"
#autorundisable
echo Pipeline version $VERSION

ln ../../*.bam ./
cp  ${DIRNAME}/*.csv ./
cp  ${DIRNAME}/*.txt ./

sudo docker run -it -v /home/ubuntu/downloads:/mnt cgrlab/typeseqhpv:final_2018080301 Rscript /mnt/TypeSeqHPV/workflow.R \
--bam_header /mnt/IonXpress_087_rawlib.txt \
--bam_files_dir /mnt/ \
--lineage_reference /mnt/20180121_lineage_reference_table_and_filters_2.csv \
--barcode_list /mnt/barcodeList_v1.csv \
--control_defs /mnt/control_defs.csv \
--run_manifest /mnt/typing_manifest.csv \
--pos_neg_filtering_criteria /mnt/2017-06-11_Pos-Neg_matrix_filtering_criteria_RefTable_v3.txt \
--scaling_table /mnt/2017-11-24_TypeSeqer_Filtering_Scaling_Table_v2.csv \
--parameter_file /mnt/hpv_types_MQ_min_max_len_filters_JUNE2017_30-10bpLen_v6.txt \
--is_torrent_server No --start_plugin /mnt/startplugin.json \
--custom_groups /mnt/report_grouping.csv \
--is_torrent_server "yes" | true

rm *.bam | true
rm */root/*/*/*filtered.json | true
rm */root/*/*/*random.json | true
rm */root/select_first_file_in_array/*.bam | true

cp */*/ion_typeseqer_report/torrent_server_html_block.html ./TypeSeqHPV_plugin_block.html

cp */*/ion_typeseqer_report/Ion_Torrent_report.pdf ./TypeSeqHPV_QC_report.pdf

zip -j TypeSeqHPV_Report_Files.zip */*/ion_typeseqer_report/*csv */*/ion_typeseqer_report/*qc_report.pdf

