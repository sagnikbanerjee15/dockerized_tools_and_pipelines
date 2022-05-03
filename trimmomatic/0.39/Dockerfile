#######################################################################################################################################################################
# Trimmomatic
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
		libidn11 fuse wget curl make zlib1g-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev cmake python3-all-dev \
		build-essential zip wget default-jre 

RUN apt-get clean
RUN echo deb http://deb.debian.org/debian/ stretch main >> /etc/apt/sources.list
RUN apt-get install -y libz-dev ncurses-dev liblzma-dev libbz2-dev libcurl4-openssl-dev

#######################################################################################################################################################################
# Trimmomatic
#######################################################################################################################################################################


ENV SW_NAME=Trimmomatic
ARG VERSION=0.39
ARG DEST=/softwares/${SW_NAME}-${VERSION}
ENV ADAPTERPATH=/softwares/${SW_NAME}-${VERSION}/adapters

RUN mkdir -p /softwares && cd /softwares && \
	wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-${VERSION}.zip -O $SW_NAME-$VERSION.zip && \
	unzip $SW_NAME-$VERSION.zip && \
	echo "alias trimmomatic='java -jar $DEST/trimmomatic-${VERSION}.jar'" >> ~/.bash_aliases && \
    echo "source ~/.bash_aliases" >> ~/.bashrc 
