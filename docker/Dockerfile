#FROM cgrlab/typeseqhpv:base_200214
FROM cgrlab/typeseqhpv:base_190221

WORKDIR /mnt

RUN Rscript -e 'require(devtools); install_github("cgrlab/TypeSeqHPV", ref = "development", force = TRUE)'

#clone repo to get other docs
RUN cd / && git clone --single-branch --branch development https://github.com/cgrlab/TypeSeqHPV.git

RUN wget https://github.com/jgm/pandoc/releases/download/2.9.2/pandoc-2.9.2-1-amd64.deb \
&& dpkg -i pandoc-2.9.2-1-amd64.deb

RUN Rscript -e 'install.packages("gridExtra")'