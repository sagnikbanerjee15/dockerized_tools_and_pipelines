#######################################################################################################################################################################
# sratools
#######################################################################################################################################################################

FROM ubuntu
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

#######################################################################################################################################################################
# SETUP
#######################################################################################################################################################################

RUN apt-get update && apt-get install -y lsb-release software-properties-common && apt-get clean all
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" && \
	apt-get --quiet install --yes zip unzip gcc rsync sudo htop vim less locales locales-all perl python3 rsync zip \
		libidn11 fuse wget curl make zlib1g-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev cmake python3-all-dev

RUN apt-get install r-base -y
RUN apt-get clean
RUN echo deb http://deb.debian.org/debian/ stretch main >> /etc/apt/sources.list
RUN apt-get install -y libz-dev ncurses-dev liblzma-dev libbz2-dev libcurl4-openssl-dev

#######################################################################################################################################################################
# sratools
#######################################################################################################################################################################

ARG VERSION=2.9.6
RUN apt-get -y -m update && apt-get --quiet install --yes libidn11 fuse libxml2-dev wget curl uuid-runtime make && apt-get clean
RUN wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${VERSION}/sratoolkit.${VERSION}-centos_linux64.tar.gz && tar -xzf sratoolkit.${VERSION}-centos_linux64.tar.gz 
ENV PATH=/sratoolkit.${VERSION}-centos_linux64/bin:${PATH}
RUN mkdir -p /root/.ncbi && \
    printf '/LIBS/IMAGE_GUID = "%s"\n' `uuidgen` > /root/.ncbi/user-settings.mkfg && \
    printf '/libs/cloud/report_instance_identity = "true"\n' >> /root/.ncbi/user-settings.mkfg
