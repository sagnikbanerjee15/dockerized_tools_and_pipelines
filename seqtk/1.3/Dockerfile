#######################################################################################################################################################################
# seqtk
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
		libidn11 fuse wget curl make zlib1g-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev cmake python3-all-dev wget

#######################################################################################################################################################################
# seqtk
#######################################################################################################################################################################

ARG VERSION=1.3

RUN mkdir /softwares && cd /softwares && \
	wget https://github.com/lh3/seqtk/archive/refs/tags/v${VERSION}.tar.gz && \
	cd seqtk-${VERSION} && \
	make

ENV PATH $PATH:/softwares/seqtk-${VERSION} 
