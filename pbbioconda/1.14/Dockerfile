#######################################################################################################################################################################
# pbbioconda
#######################################################################################################################################################################

FROM ubuntu:20.04
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

#######################################################################################################################################################################
# SETUP
#######################################################################################################################################################################

RUN apt-get update && apt-get install -y lsb-release software-properties-common && apt-get clean all
ADD https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh /tmp/miniconda.sh

RUN set -e \
      && ln -sf bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        ca-certificates curl \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -e \
      && /bin/bash /tmp/miniconda.sh -b -p /opt/conda \
      && /opt/conda/bin/conda update -n base -c defaults conda \
      && /opt/conda/bin/conda clean -ya \
      && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
      && echo '. /opt/conda/etc/profile.d/conda.sh' >> /etc/profile \
      && echo 'conda activate base' >> /etc/profile \
      && rm -f /tmp/miniconda.sh

ENV PATH /opt/conda/bin:${PATH}

RUN set -e \
      && conda config --add channels defaults \
      && conda config --add channels bioconda \
      && conda config --add channels conda-forge \
      && conda clean -ya \
      && rm -rf /root/.cache/pip

#######################################################################################################################################################################
# pbbioconda
#######################################################################################################################################################################

RUN conda install -c bioconda pbaa

RUN apt-get update 
RUN apt-get install -y wget
ARG VERSION=1.14
RUN mkdir -p /softwares/samtools && \
	cd /softwares/samtools && \
	wget https://github.com/samtools/samtools/releases/download/${VERSION}/samtools-${VERSION}.tar.bz2 && \
	tar jxf samtools-${VERSION}.tar.bz2 && \
	cd samtools-${VERSION} && make && make install && \
	cd .. && rm samtools-${VERSION}.tar.bz2