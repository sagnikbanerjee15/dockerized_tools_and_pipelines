#######################################################################################################################################################################
# SMRTLINK
#######################################################################################################################################################################

FROM ubuntu
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines


#######################################################################################################################################################################
# SETUP
#######################################################################################################################################################################

RUN apt-get update && apt-get install -y lsb-release software-properties-common && apt-get clean all
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" && \
	apt-get --quiet install --yes zip unzip gcc rsync sudo htop vim less locales locales-all perl python3 rsync zip \
		  fuse wget curl make zlib1g-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev cmake python3-all-dev wget

#######################################################################################################################################################################
# SMRTLINK
#######################################################################################################################################################################

ARG VERSION=10.1.0.119588
ENV SMRT_ROOT /softwares/smrtlink/bin
ENV SMRT_USER smrtanalysis

RUN apt-get -y -m update && \
	apt-get --quiet install --yes sudo htop vim less locales locales-all perl python3 rsync zip   fuse wget curl make && \
	apt-get clean && \
	mkdir -p /softwares/smrtlink && \
	cd /softwares && \
	cd smrtlink && \
	wget https://downloads.pacbcloud.com/public/software/installers/smrtlink_${VERSION}.zip && \
	unzip smrtlink_${VERSION}.zip && \
	./smrtlink_${VERSION}.run --rootdir $SMRT_ROOT --smrttools-only

ENV PATH $PATH:/softwares/smrtlink/bin/current/bundles/smrttools/smrtcmds/bin
