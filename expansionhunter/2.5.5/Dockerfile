###################################################################################################################################################################################################
# Expansion Hunter 2.5.5
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
# Expansion Hunter 2.5.5
###################################################################################################################################################################################################

ARG VERSION=2.5.5
SHELL ["/bin/bash", "-c"]
RUN mkdir -p /softwares/expansionhunter && \
	cd /softwares && \
	chmod 777 -R expansionhunter && \
	cd expansionhunter && \
	wget https://github.com/Illumina/ExpansionHunter/releases/download/v${VERSION}/ExpansionHunter-v${VERSION}-linux_x86_64.tar.gz && \
	tar -xzf ExpansionHunter-v${VERSION}-linux_x86_64.tar.gz && \
	rm ExpansionHunter-v${VERSION}-linux_x86_64.tar.gz 

ENV PATH $PATH:/softwares/expansionhunter/ExpansionHunter-v${VERSION}-linux_x86_64/bin:/softwares/expansionhunter/ExpansionHunter-v${VERSION}-linux_x86_64/variant_catalog
