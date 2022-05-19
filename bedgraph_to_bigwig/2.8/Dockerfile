#######################################################################################################################################################################
# Bedgraph_to_bigwig
#######################################################################################################################################################################

FROM ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/samtools:1.14 
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

#######################################################################################################################################################################
# BEDGRAPH-TO-BIGWIG
#######################################################################################################################################################################

RUN mkdir -p /softwares/bedgraphtobigwig && cd /softwares/bedgraphtobigwig &&\
	wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedGraphToBigWig && \
	chmod +x bedGraphToBigWig

ENV PATH="$PATH:/softwares/bedgraphtobigwig"