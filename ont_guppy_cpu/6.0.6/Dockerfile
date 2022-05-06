###################################################################################################################################################################################################
# ont_guppy_cpu
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
RUN apt-get -y install git python3 less vim wget time zlib1g zlib1g-dev lzma-dev \
	libncurses5-dev libcurl4-nss-dev liblzma-dev libncursesw5-dev make unzip zip build-essential \
	gcc g++ cmake ca-certificates libbz2-dev xz-utils htop autoconf automake binutils bison flex \
	gettext libtool make patch pkg-config p7zip-full p7zip r-base curl sudo python3-pip dpkg
RUN apt-get clean all
RUN apt-get autoclean autoremove

###################################################################################################################################################################################################
# ONT GUPPY
###################################################################################################################################################################################################

ARG ONT_GUPPY_CPU_VERSION=6.0.6
RUN mkdir -p /softwares && cd /softwares && wget https://mirror.oxfordnanoportal.com/software/analysis/ont-guppy-cpu_${ONT_GUPPY_CPU_VERSION}_linux64.tar.gz
RUN cd /softwares && tar -xvzf ont-guppy-cpu_${ONT_GUPPY_CPU_VERSION}_linux64.tar.gz

ENV PATH=$PATH:/softwares/ont-guppy-cpu/bin:/softwares/ont-guppy-cpu/data:/softwares/ont-guppy-cpu/lib

