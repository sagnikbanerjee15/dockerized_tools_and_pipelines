#######################################################################################################################################################################
# msisensor2
#######################################################################################################################################################################

FROM ghcr.io/sagnikbanerjee15/dockerized_tools_and_pipelines/samtools:1.14
LABEL maintainer="sagnikbanerjee15@gmail.com" 
LABEL org.opencontainers.image.source https://github.com/sagnikbanerjee15/dockerized_tools_and_pipelines


ENV TZ=America/New_York
ENV DEBIAN_FRONTEND=noninteractive

#######################################################################################################################################################################
# RUFFUS
#######################################################################################################################################################################

RUN apt-get install -y python3-pip
RUN pip3 install ruffus
RUN pip3 install numpy matplotlib seaborn


#######################################################################################################################################################################
# msisensor2
#######################################################################################################################################################################

RUN apt-get install -y git

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
RUN cd /softwares && \
	git clone https://github.com/niu-lab/msisensor2.git && \
	cd msisensor2 && \
	chmod a+x *
	
ENV PATH=$PATH:/softwares/msisensor2