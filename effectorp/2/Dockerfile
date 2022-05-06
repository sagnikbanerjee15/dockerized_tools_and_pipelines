###################################################################################################################################################################################################
# Effectorp - version 2
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
	gettext libtool make patch pkg-config p7zip-full p7zip r-base curl sudo python3-pip
RUN sudo apt install default-jre -y
RUN apt-get clean all
RUN pip install numpy
RUN sudo apt-get autoclean autoremove

###################################################################################################################################################################################################
# Effectorp-v2
###################################################################################################################################################################################################


ARG EFFECTORP_VERSION=2.0.1
RUN mkdir /softwares && cd /softwares && wget https://github.com/JanaSperschneider/EffectorP-2.0/archive/refs/tags/v${EFFECTORP_VERSION}.tar.gz
RUN cd /softwares && tar -xvzf v${EFFECTORP_VERSION}.tar.gz
RUN cd /softwares && chmod -R 755 EffectorP-2.0-${EFFECTORP_VERSION}/
RUN sudo apt-get install -y xorg-dev
RUN cd /softwares/EffectorP-2.0-${EFFECTORP_VERSION}/Scripts && tar xvf emboss-latest.tar.gz && \
	cd EMBOSS-6.5.7/ && \
	./configure && \
	make && \
	cd ../ && \
	unzip weka-3-8-1.zip && \
	rm /softwares/v${EFFECTORP_VERSION}.tar.gz
	
ENV PATH=$PATH:/softwares/EffectorP-2.0.1/:/softwares/EffectorP-2.0.1/Scripts

