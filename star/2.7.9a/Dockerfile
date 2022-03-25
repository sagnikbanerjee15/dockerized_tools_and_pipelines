FROM ubuntu
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>

ARG VERSION=2.7.9a
RUN apt-get -y update && \
	apt-get install -y --no-install-recommends python3 less vim wget build-essential zlib1g-dev libncurses5-dev gcc g++ make unzip zip && \
	apt-get clean && \
	mkdir /softwares && \
	cd /softwares && \
	wget --no-check-certificate https://github.com/alexdobin/STAR/archive/${VERSION}.zip && \
	unzip ${VERSION}.zip && \
	cd STAR-${VERSION}/source && \
	make STAR STARlong

ENV PATH /softwares/STAR-${VERSION}/source:${PATH}
