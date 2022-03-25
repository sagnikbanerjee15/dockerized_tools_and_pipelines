FROM ubuntu
MAINTAINER Sagnik Banerjee <sagnikbanerjeee15@gmail.com>

ARG VERSION=1.14

RUN apt-get -y update && \
	apt-get install -y wget build-essential time zlib1g-dev libncurses5-dev liblzma-dev libbz2-dev libcurl4-openssl-dev  && \
	mkdir -p /softwares/samtools && \
	cd /softwares/samtools && \
	wget https://github.com/samtools/samtools/releases/download/${VERSION}/samtools-${VERSION}.tar.bz2 && \
	tar jxf samtools-${VERSION}.tar.bz2 && \
	cd samtools-${VERSION} && make && make install && \
	cd .. && rm samtools-${VERSION}.tar.bz2

