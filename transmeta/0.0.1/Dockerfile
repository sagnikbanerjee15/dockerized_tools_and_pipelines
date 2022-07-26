#######################################################################################################################################################################
# Transmeta
#######################################################################################################################################################################

FROM ubuntu
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

#######################################################################################################################################################################
# SETUP
#######################################################################################################################################################################

RUN apt-get update && apt-get install -y lsb-release software-properties-common && apt-get clean all
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe"
RUN apt-get --quiet install --yes zip unzip rsync sudo htop vim less locales locales-all perl python3 rsync zip \
		  fuse wget curl make zlib1g-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev cmake python3-all-dev \
		  build-essential zlib1g-dev libncurses5-dev gcc g++ git
RUN apt-get clean

#######################################################################################################################################################################
# Boost
#######################################################################################################################################################################

ARG BOOST_VERSION=1_55_0
RUN apt-get install -y autotools-dev libicu-dev libbz2-dev libboost-all-dev
RUN mkdir -p /softwares && \
    cd /softwares && \
    wget https://sourceforge.net/projects/boost/files/boost/1.55.0/boost_${BOOST_VERSION}.tar.gz && \
    tar -zxvf boost_${BOOST_VERSION}.tar.gz && \
    cd boost_${BOOST_VERSION} && \
    ./bootstrap.sh && \
    ./b2 install --prefix=/softwares/boost_installation
    
ENV PATH /softwares/boost_installation:${PATH}
    

#######################################################################################################################################################################
# Bamtools
#######################################################################################################################################################################

RUN mkdir -p /softwares && \
	cd /softwares && \
	git clone https://github.com/pezmaster31/bamtools.git && \
	cd bamtools && \
	mkdir build && \
	cd build && \
	cmake -DCMAKE_INSTALL_PREFIX=/softwares/bamtools_installation .. && \
	make && make install

#######################################################################################################################################################################
# Transmeta
#######################################################################################################################################################################

ARG VERSION=0.0.1
RUN mkdir -p /softwares && \
	cd /softwares && \
	git clone https://github.com/yutingsdu/TransMeta.git && \
	cd TransMeta/src && \
	make all BOOST_PATH=/softwares/boost_installation BAMTOOLS_PATH=/softwares/bamtools_installation
	

ENV PATH /softwares/TransMeta:${PATH}
ENV LD_LIBRARY_PATH /softwares/boost_installation/lib:$LD_LIBRARY_PATH