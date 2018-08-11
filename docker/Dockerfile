FROM cgrlab/typeseqhpv:base_2018081002
RUN Rscript -e 'require(devtools); install_github("cgrlab/TypeSeqHPV", force=TRUE)'

#clone repo to get other docs
RUN mkdir /TypeSeqHPV && \
cd /TypeSeqHPV && \
git init && \
git pull https://github.com/cgrlab/TypeSeqHPV.git
