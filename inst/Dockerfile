FROM cgrlab/typeseqhpv:base_2018062901
RUN Rscript -e 'require(devtools); install_github("cgrlab/TypeSeqHPV", force=TRUE)'
RUN Rscript -e 'require(TypeSeqHPV); ion_report_load_packages(); install_binaries()'

#clone repo to get other docs
RUN mkdir /TypeSeqHPV && \
cd /TypeSeqHPV && \
git init && \
git pull https://github.com/cgrlab/TypeSeqHPV.git

RUN cp --backup=numbered /TypeSeqHPV/docs/*/*txt /TypeSeqHPV/docs/*/*csv /opt
