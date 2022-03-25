FROM ubuntu:latest

ARG VERSION=2.9.6
RUN apt-get -y -m update && apt-get --quiet install --yes libidn11 fuse libxml2-dev wget curl uuid-runtime make && apt-get clean
RUN wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${VERSION}/sratoolkit.${VERSION}-centos_linux64.tar.gz && tar -xzf sratoolkit.${VERSION}-centos_linux64.tar.gz 
ENV PATH=/sratoolkit.${VERSION}-centos_linux64/bin:${PATH}
RUN mkdir -p /root/.ncbi && \
    printf '/LIBS/IMAGE_GUID = "%s"\n' `uuidgen` > /root/.ncbi/user-settings.mkfg && \
    printf '/libs/cloud/report_instance_identity = "true"\n' >> /root/.ncbi/user-settings.mkfg
