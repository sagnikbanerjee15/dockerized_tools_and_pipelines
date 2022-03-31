#######################################################################################################################################################################
# Stringtie
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
# Stringtie
#######################################################################################################################################################################

ARG VERSION=2.2.1
RUN mkdir -p /opt/tools

RUN mkdir /softwares && \
  wget -c http://ccb.jhu.edu/software/stringtie/dl/stringtie-${VERSION}.Linux_x86_64.tar.gz && \
  tar -zxvf stringtie-${VERSION}.Linux_x86_64.tar.gz && \
  cp stringtie-${version}.Linux_x86_64/stringtie /usr/local/bin && \
  rm -rf stringtie* && \
  apt-get remove --purge --yes \
              wget && \
  apt-get autoremove --purge --yes && \
  apt-get clean

