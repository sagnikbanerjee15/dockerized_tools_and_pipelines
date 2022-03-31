###################################################################################################################################################################################################
# ART
###################################################################################################################################################################################################
FROM ubuntu:latest
MAINTAINER Sagnik Banerjee
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines

RUN apt-get -y -m update && apt-get --quiet install --yes wget && apt-get clean
RUN wget https://www.niehs.nih.gov/research/resources/assets/docs/artbinmountrainier2016.06.05linux64.tgz && tar -xzf artbinmountrainier2016.06.05linux64.tgz

ENV PATH=/art_bin_MountRainier/:${PATH}
