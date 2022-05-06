###################################################################################################################################################################################################
# Effectorp - version 3
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
# Effectorp-v3
###################################################################################################################################################################################################


ARG EFFECTORP_VERSION=3.0.0
RUN mkdir /softwares && cd /softwares && wget https://github.com/JanaSperschneider/EffectorP-3.0/archive/refs/tags/v${EFFECTORP_VERSION}-beta.tar.gz
RUN cd /softwares && tar -xvzf v${EFFECTORP_VERSION}-beta.tar.gz
RUN cd /softwares && chmod -R 755 EffectorP-3.0-${EFFECTORP_VERSION}-beta/
RUN cd /softwares/EffectorP-3.0-${EFFECTORP_VERSION}-beta && \
	unzip weka-3-8-4.zip && \
	rm /softwares/v${EFFECTORP_VERSION}-beta.tar.gz
	
ENV PATH=$PATH:/softwares/EffectorP-${EFFECTORP_VERSION}-beta/

