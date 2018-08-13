FROM cgrlab/typeseqhpv:base_2018081002
RUN apt-get install -y lmodern

RUN Rscript -e 'require(devtools); install_github("cgrlab/TypeSeqHPV", force=TRUE)'

RUN Rscript -e 'install.packages("furrr", "future")'

RUN Rscript -e 'source("https://bioconductor.org/biocLite.R"); biocLite("GenomicAlignments")'

#clone repo to get other docs
RUN mkdir /TypeSeqHPV && \
cd /TypeSeqHPV && \
git init && \
git pull https://github.com/cgrlab/TypeSeqHPV.git
