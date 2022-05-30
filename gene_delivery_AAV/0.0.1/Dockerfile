#######################################################################################################################################################################
# Gene Delivery AAV
#######################################################################################################################################################################

FROM ubuntu

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

#######################################################################################################################################################################
# SETUP
#######################################################################################################################################################################

RUN apt-get update && apt-get install -y lsb-release software-properties-common && apt-get clean all
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" && \
	apt-get --quiet install --yes zip unzip gcc rsync sudo htop vim less locales locales-all perl python3 rsync zip \
    fuse wget curl make zlib1g-dev libffi-dev libncurses5-dev libcurl4-gnutls-dev libssl-dev cmake python3-all-dev
RUN echo deb http://deb.debian.org/debian/ stretch main >> /etc/apt/sources.list
RUN apt-get install -y libz-dev ncurses-dev liblzma-dev libbz2-dev libcurl4-openssl-dev

#######################################################################################################################################################################
# RUFFUS
#######################################################################################################################################################################

RUN apt-get install -y python3-pip
RUN pip3 install ruffus


#######################################################################################################################################################################
# Gene Delivery AAV
#######################################################################################################################################################################

RUN apt-get install -y git

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
RUN mkdir /softwares && \
	cd /softwares && \
	git clone https://biogit.pri.bms.com/baners23/AAV.git && \
	cd AAV && \
	chmod a+x *
	
ENV PATH=$PATH:/softwares/AAV_STEALTH

