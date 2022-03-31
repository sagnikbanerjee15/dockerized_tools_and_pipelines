###################################################################################################################################################################################################
# Minimap2 - 2.24
###################################################################################################################################################################################################

FROM ubuntu
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

###################################################################################################################################################################################################
# Update base image and install software
###################################################################################################################################################################################################

RUN apt-get -y update
RUN apt-get -y install git python3.8 less vim wget time zlib1g zlib1g-dev lzma-dev \
	libncurses5-dev libcurl4-nss-dev liblzma-dev libncursesw5-dev make unzip zip build-essential \
	gcc g++ cmake ca-certificates libbz2-dev xz-utils htop autoconf automake binutils bison flex \
	gettext libtool make patch pkg-config p7zip-full p7zip python r-base curl sudo python3-pip
RUN apt-get clean all
RUN pip install numpy
RUN sudo apt-get autoclean autoremove

###################################################################################################################################################################################################
# Expansion Hunter 2.5.5
###################################################################################################################################################################################################

ARG VERSION=2.24
SHELL ["/bin/bash", "-c"]
RUN mkdir -p /softwares && \
	cd /softwares && \
	wget https://github.com/lh3/minimap2/releases/download/v2.24/minimap2-${VERSION}_x64-linux.tar.bz2 && \
	tar -xf minimap2-${VERSION}_x64-linux.tar.bz2 && \
	mv minimap2-${VERSION}_x64-linux minimap2

ENV PATH $PATH:/softwares/minimap2