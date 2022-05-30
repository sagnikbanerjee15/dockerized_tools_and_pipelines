
###################################################################################################################################################################################################
# Gene Delivery AAV
###################################################################################################################################################################################################
FROM ubuntu
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

# Update base image and install software
RUN apt-get -y update
RUN apt-get -y install git python3 less vim wget time zlib1g zlib1g-dev lzma-dev \
	libncurses5-dev libcurl4-nss-dev liblzma-dev libncursesw5-dev make unzip zip build-essential \
	gcc g++ cmake ca-certificates libbz2-dev xz-utils htop autoconf automake binutils bison flex \
	gettext libtool make patch pkg-config p7zip-full p7zip r-base pip
RUN apt-get clean all

###################################################################################################################################################################################################
# Gene Delivery AAV
###################################################################################################################################################################################################

RUN pip install ruffus
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
ARG AAV_VERSION=1.1.0
RUN mkdir -p /software && cd /software && \
	git clone git@biogit.pri.bms.com:baners23/AAV_STEALTH.git &&\
	cd AAV_STEALTH	
	
ENV PATH=${PATH}:/software/AAV_STEALTH







