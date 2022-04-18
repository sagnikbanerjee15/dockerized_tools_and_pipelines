#######################################################################################################################################################################
# GFFREAD
#######################################################################################################################################################################

FROM bioconductor/bioconductor_docker:RELEASE_3_14
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

# Install DESeq2 and FactoMineR package  
RUN R -e 'BiocManager::install("DESeq2")'