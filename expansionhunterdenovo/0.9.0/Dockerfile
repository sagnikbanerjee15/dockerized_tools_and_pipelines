###################################################################################################################################################################################################
# ExpansionHunterDeNovo - 0.9.0
###################################################################################################################################################################################################

FROM ubuntu
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ARG VERSION=0.9.0
SHELL ["/bin/bash", "-c"]
RUN apt-get -y -m update && \
	apt-get install -y wget build-essential time zlib1g-dev libncurses5-dev liblzma-dev libbz2-dev libcurl4-openssl-dev  && \
	apt-get --quiet install --yes sudo time python3 less locales locales-all perl python3 rsync zip   fuse wget curl make python3-pip && \
	pip3 install scipy numpy && \
	apt-get clean && \
	mkdir -p /softwares/expansionhunterdenovo && \
	cd /softwares && \
	chmod 777 -R expansionhunterdenovo && \
	cd expansionhunterdenovo && \
	wget https://github.com/Illumina/ExpansionHunterDenovo/releases/download/v0.9.0/ExpansionHunterDenovo-v${VERSION}-linux_x86_64.tar.gz && \
	tar -xzf ExpansionHunterDenovo-v${VERSION}-linux_x86_64.tar.gz && \
	rm ExpansionHunterDenovo-v${VERSION}-linux_x86_64.tar.gz 

ENV PATH $PATH:/softwares/expansionhunterdenovo/ExpansionHunterDenovo-v${VERSION}-linux_x86_64/bin:/softwares/expansionhunterdenovo/ExpansionHunterDenovo-v${VERSION}-linux_x86_64/scripts
