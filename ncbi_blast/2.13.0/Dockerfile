###################################################################################################################################################################################################
# BLAST - 2.13.0
###################################################################################################################################################################################################

FROM ubuntu
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

###################################################################################################################################################################################################
# Update base image and install software
###################################################################################################################################################################################################

RUN apt-get -y update
RUN apt-get -y install git python3.8 less vim wget time zlib1g zlib1g-dev lzma-dev \
	libncurses5-dev libcurl4-nss-dev liblzma-dev libncursesw5-dev make unzip zip build-essential \
	gcc g++ cmake ca-certificates libbz2-dev xz-utils htop autoconf automake binutils bison flex \
	gettext libtool make patch pkg-config p7zip-full p7zip r-base curl sudo python3-pip
RUN apt-get clean all
RUN pip install numpy
RUN sudo apt-get autoclean autoremove

###################################################################################################################################################################################################
# BLAST - 2.13.0
###################################################################################################################################################################################################

ARG VERSION=2.13.0

RUN mkdir -p /softwares && \
	cd /softwares && \
	wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-${VERSION}+-x64-linux.tar.gz && \
	tar -xvzf ncbi-blast-${VERSION}+-x64-linux.tar.gz

ENV PATH $PATH:/softwares/ncbi-blast-${VERSION}+/bin