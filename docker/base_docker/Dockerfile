FROM ubuntu:16.04

MAINTAINER David Roberson, david.roberson@nih.gov

WORKDIR /home

RUN apt-get update && apt-get install -y \
	git \
	openjdk-8-jdk \
	python \
	libnss3 \
	curl

RUN set -x -v -e

# spark

RUN mkdir /opt/apache-spark
RUN curl http://www.gtlib.gatech.edu/pub/apache/spark/spark-2.3.3/spark-2.3.3-bin-hadoop2.7.tgz \
  | tar --strip-components=1 -xzC /opt/apache-spark

# maven
# we rely on apache maven > 3.1.1 to build ADAM, so we can't use the
# version of maven installed by apt-get

RUN mkdir /opt/apache-maven
RUN curl http://www.gtlib.gatech.edu/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
  | tar --strip-components=1 -xzC /opt/apache-maven

ENV PATH /opt/apache-spark/bin:$PATH
ENV MAVEN_HOME /opt/apache-maven-

# clone adam
RUN git clone https://github.com/fnothaft/adam.git

ENV MAVEN_OPTS "-Xmx2g"

# build adam
WORKDIR /home/adam
RUN git checkout 2059-2064

RUN /opt/apache-maven/bin/mvn package -DskipTests

# R is below

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | tee -a /etc/apt/sources.list

RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9

RUN gpg -a --export E084DAB9 | apt-key add

RUN apt-get update && apt-get install -y --no-install-recommends \
r-base \
r-base-dev \
software-properties-common \
libcurl4-openssl-dev \
libxml2-dev \
libcairo2-dev \
libssl-dev \
libpng-dev \
ed \
curl \
wget \
less \
locales \
vim-tiny \
ca-certificates \
git \
texlive-latex-recommended \
texlive-latex-extra \
texlive-fonts-recommended \
texlive-fonts-extra \
autoconf \
automake \
make \
g++ \
gcc \
build-essential \
zlib1g-dev \
libgsl0-dev \
perl \
unzip \
tabix \
libncurses5-dev \
samtools \
lmodern


# install aws cli
RUN apt-get install -y python-pip
RUN pip install awscli

#install bwa
RUN git clone https://github.com/lh3/bwa.git
RUN cd bwa; make


#install sambamba
RUN wget https://github.com/biod/sambamba/releases/download/v0.6.7/sambamba_v0.6.7_linux.tar.bz2
RUN tar xvjf sambamba_v0.6.7_linux.tar.bz2

#install gatk 4.0
RUN wget https://github.com/broadinstitute/gatk/releases/download/4.0.6.0/gatk-4.0.6.0.zip && \
unzip gatk-4.0.6.0.zip

#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get install -y default-jre default-jdk

RUN wget https://github.com/jgm/pandoc/releases/download/2.0.1.1/pandoc-2.0.1.1-1-amd64.deb \
&& dpkg -i pandoc-2.0.1.1-1-amd64.deb

RUN Rscript -e 'install.packages(c("tidyverse", "devtools", "jsonlite", "pander", "scales","knitr", "koRpus", \
"pandoc",\
"rmarkdown",\
"fuzzyjoin",\
"ggsci",\
"CodeDepends",\
"visNetwork",\
"txtq",\
"webshot",\
"networkD3",\
"future",\
"drake", \
"parallel",\
"optigrab",\
"formatR",\
"remotes",\
"stringi",\
"V8",\
"DT",\
"gtools",\
"gridExtra",\
"furrr"))'

RUN Rscript -e 'source("https://bioconductor.org/biocLite.R"); biocLite("GenomicAlignments")'

# Below is TVC

WORKDIR /opt

# Update the repository sources list
RUN apt-get update && apt-get install --yes \
    gcc-multilib \
    apt-utils \
    g++ \
    cmake \
    python-dev \
    libbz2-dev \
    libboost-math-dev \
    aptitude

RUN aptitude install -y \
    libatlas-dev \
    liblapack-dev

RUN wget updates.iontorrent.com/tvc_standalone/tvc-5.10.1.tar.gz

RUN mkdir -p tvc_5_10_1_main/bin/

# 4. build armadillo
RUN wget http://updates.iontorrent.com/updates/software/external/armadillo-4.600.1.tar.gz && \
tar -xvzf armadillo-4.600.1.tar.gz && \
cd armadillo-4.600.1/ && \
sed -i 's:^// #define ARMA_USE_LAPACK$:#define ARMA_USE_LAPACK:g' include/armadillo_bits/config.hpp && \
sed -i 's:^// #define ARMA_USE_BLAS$:#define ARMA_USE_BLAS:g'     include/armadillo_bits/config.hpp && \
cmake . && \
make -j4

# 5. build bamtools
RUN wget updates.iontorrent.com/updates/software/external/bamtools-2.4.0.20150702+git15eadb925f.tar.gz && \
tar -xvzf bamtools-2.4.0.20150702+git15eadb925f.tar.gz && \
mkdir bamtools-2.4.0.20150702+git15eadb925f-build && \
cd bamtools-2.4.0.20150702+git15eadb925f-build && \
cmake ../bamtools-2.4.0.20150702+git15eadb925f -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo && \
make -j4

# 7. build htslib
RUN wget --no-check-certificate https://github.com/samtools/htslib/archive/1.2.1.tar.gz -O htslib-1.2.1.tar.gz && \
tar xvzf htslib-1.2.1.tar.gz && \
ln -s htslib-1.2.1 htslib && \
cd htslib-1.2.1 && \
make -j4

# 8. build samtools
RUN wget --no-check-certificate https://github.com/samtools/samtools/archive/1.2.tar.gz -O samtools-1.2.tar.gz && \
tar xvzf samtools-1.2.tar.gz && \
cd samtools-1.2 && \
make -j4 && \
cp samtools /opt/tvc_5_10_1_main/bin/

# build TVC
RUN tar -xvzf tvc-5.10.1.tar.gz && \
mkdir tvc-5_10_1-build && \
cd tvc-5_10_1-build && \
cmake /opt/tvc-5.10.1 -DCMAKE_INSTALL_PREFIX:PATH=/opt/tvc_5_10_1_main/ -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo && \
make -j4 install

# update PATH variable

ENV PATH=$PATH:/opt/tvc_5_10_1_main/bin

WORKDIR /mnt

RUN Rscript -e 'install.packages("vcfR")'

RUN pip install -U git+https://github.com/randy3k/rapi
RUN pip install -U git+https://github.com/randy3k/lineedit
RUN pip install -U git+https://github.com/randy3k/rtichoke


