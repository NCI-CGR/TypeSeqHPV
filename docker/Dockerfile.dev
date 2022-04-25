FROM cgrlab/typeseqhpv:base_18110801

WORKDIR /mnt

RUN Rscript -e 'devtools::install_github("cgrlab/TypeSeqHPV", ref="master", force=TRUE)'

RUN cd / && git clone --single-branch --branch master https://github.com/cgrlab/TypeSeqHPV.git

#clone repo to get other docs
# RUN mkdir /TypeSeqHPV && \
# cd /TypeSeqHPV && \
# git init && \
# git pull https://github.com/cgrlab/TypeSeqHPV.git

# RUN pip install -U git+https://github.com/randy3k/rapi
# RUN pip install -U git+https://github.com/randy3k/lineedit
# RUN pip install -U git+https://github.com/randy3k/rtichoke
