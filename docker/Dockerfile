FROM cgrlab/typeseqhpv:base_18110801

WORKDIR /mnt

RUN Rscript -e 'require(devtools); install_github("cgrlab/TypeSeqHPV", ref = "dev", force = TRUE)'

RUN apt-get install -y libmariadb-client-lgpl-dev

RUN Rscript -e 'source("https://bioconductor.org/biocLite.R"); biocLite("VariantAnnotation"); biocLite("genoset")'

RUN Rscript -e 'require(devtools); install_github("seandavi/VCFWrenchR")'

#clone repo to get other docs
RUN cd / && git clone --single-branch --branch dev https://github.com/cgrlab/TypeSeqHPV.git

RUN pip install -U git+https://github.com/randy3k/rapi
RUN pip install -U git+https://github.com/randy3k/lineedit
RUN pip install -U git+https://github.com/randy3k/rtichoke
