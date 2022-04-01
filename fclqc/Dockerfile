#######################################################################################################################################################################
# FCLQC
#######################################################################################################################################################################

FROM rust
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

#######################################################################################################################################################################
# SETUP
#######################################################################################################################################################################

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

# Update base image and install software
RUN apt-get -y update
RUN apt-get -y install git python3 less vim wget time zlib1g zlib1g-dev lzma-dev \
	libncurses5-dev libcurl4-nss-dev liblzma-dev libncursesw5-dev make unzip zip build-essential \
	gcc g++ cmake ca-certificates libbz2-dev xz-utils htop autoconf automake binutils bison flex \
	gettext libtool make patch pkg-config p7zip-full p7zip python r-base
RUN apt-get clean all

#######################################################################################################################################################################
# FCLQC
#######################################################################################################################################################################

RUN mkdir -p /softwares && cd /softwares
RUN cd /softwares && git clone https://github.com/Minhyeok01/FCLQC.git
RUN cd /softwares/FCLQC && cargo build --release