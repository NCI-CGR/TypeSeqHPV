FROM cgrlab/typeseqhpv:base_18110801

RUN Rscript -e 'require(devtools); install_github("cgrlab/TypeSeqHPV", force=TRUE)'

#clone repo to get other docs
RUN mkdir /TypeSeqHPV && \
cd /TypeSeqHPV && \
git init && \
git pull https://github.com/cgrlab/TypeSeqHPV.git

#RUN pip install -U git+https://github.com/randy3k/rapi
#RUN pip install -U git+https://github.com/randy3k/lineedit
#RUN pip install -U git+https://github.com/randy3k/rtichoke
