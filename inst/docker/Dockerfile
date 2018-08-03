FROM cgrlab/typeseqhpv:base_2018062901
RUN Rscript -e 'require(devtools); install_github("cgrlab/TypeSeqHPV", force=TRUE)'
RUN Rscript -e 'require(TypeSeqHPV); ion_report_load_packages(); install_binaries()'
