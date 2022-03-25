FROM ubuntu:latest
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>

ARG VERSION=10.1.0.119588
ENV SMRT_ROOT /softwares/smrtlink/bin
ENV SMRT_USER smrtanalysis

RUN apt-get -y -m update && \
	apt-get --quiet install --yes sudo htop vim less locales locales-all perl python3 rsync zip libidn11 fuse wget curl make && \
	apt-get clean && \
	mkdir -p /softwares/smrtlink && \
	cd /softwares && \
	cd smrtlink && \
	wget https://downloads.pacbcloud.com/public/software/installers/smrtlink_${VERSION}.zip && \
	unzip smrtlink_${VERSION}.zip && \
	./smrtlink_${VERSION}.run --rootdir $SMRT_ROOT --smrttools-only

ENV PATH $PATH:/softwares/smrtlink/bin/current/bundles/smrttools/smrtcmds/bin
