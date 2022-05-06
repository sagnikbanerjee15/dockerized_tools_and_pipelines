###################################################################################################################################################################################################
# Bedops
###################################################################################################################################################################################################

FROM ubuntu
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ARG VERSION=2.4.40
SHELL ["/bin/bash", "-c"]
RUN apt-get -y -m update && \
	apt-get install -y wget build-essential time zlib1g-dev libncurses5-dev liblzma-dev libbz2-dev libcurl4-openssl-dev  && \
	apt-get --quiet install --yes sudo time python3 less locales locales-all perl python3 rsync zip   fuse wget curl make python3-pip && \
	apt-get clean && \
	mkdir -p /softwares/bedops && \
	cd /softwares && \
	chmod 777 -R bedops && \
	cd bedops && \
	wget https://github.com/bedops/bedops/releases/download/v${VERSION}/bedops_linux_x86_64-v${VERSION}.tar.bz2 && \
	tar -xf bedops_linux_x86_64-v${VERSION}.tar.bz2 && \
	rm bedops_linux_x86_64-v${VERSION}.tar.bz2

ENV PATH $PATH:/softwares/bedops/bin
