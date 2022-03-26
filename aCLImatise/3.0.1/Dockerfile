###################################################################################################################################################################################################
# aCLImatise
###################################################################################################################################################################################################

FROM ubuntu
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y -m update && \
	apt-get install -y wget build-essential time zlib1g-dev libncurses5-dev liblzma-dev libbz2-dev libcurl4-openssl-dev  && \
	apt-get --quiet install --yes sudo time python3 less locales locales-all perl python rsync zip libidn11 fuse wget curl make python-pip && \
	apt-get clean
	

###################################################################################################################################################################################################
# argparse2tool
###################################################################################################################################################################################################

RUN pip install aclimatise
RUN python -m spacy download en