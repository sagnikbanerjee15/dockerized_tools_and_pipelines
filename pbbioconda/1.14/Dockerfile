#######################################################################################################################################################################
# pbbioconda
#######################################################################################################################################################################

FROM bioconda/bioconda-utils-build-env
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

#######################################################################################################################################################################
# pbbioconda
#######################################################################################################################################################################

ARG VERSION=1.14

RUN conda install -c bioconda pbaa
RUN yum update 
RUN yum install -y curl-devel gcc wget build-essential time bzip2-devel.x86_64 zlib1g-dev libncurses5-dev liblzma-dev libbz-dev libcurl4-openssl-dev zlib-devel.x86_64 ncurses-devel ncurses xz-devel && \
	mkdir -p /softwares/samtools && \
	cd /softwares/samtools && \
	wget https://github.com/samtools/samtools/releases/download/${VERSION}/samtools-${VERSION}.tar.bz2 && \
	tar jxf samtools-${VERSION}.tar.bz2 && \
	cd samtools-${VERSION} && make && make install && \
	cd .. && rm samtools-${VERSION}.tar.bz2