#######################################################################################################################################################################
# fgmp
#######################################################################################################################################################################

FROM continuumio/miniconda3
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

#######################################################################################################################################################################
# SETUP
#######################################################################################################################################################################

RUN apt-get update && apt-get install -y lsb-release software-properties-common && apt-get clean all


#######################################################################################################################################################################
# fgmp
#######################################################################################################################################################################

RUN conda install -c bioconda hmmer
RUN conda install -c bioconda blast
RUN conda install -c bioconda exonerate
RUN conda install -c bioconda augustus
RUN conda install -c bioconda emboss
RUN conda install -c bioconda perl-ipc-run
RUN conda install -c bioconda perl-bioperl


RUN apt-get install gcc make -y
RUN mkdir /softwares && \
	cd /softwares && \
	git clone https://github.com/stajichlab/FGMP.git && \
	cd FGMP && \
	perl Makefile.PL && \
	make

RUN conda install -c bioconda perl-io-all
RUN cpanm Bio::Perl
	


ENV PATH=${PATH}:/softwares/FGMP/src