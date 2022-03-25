FROM ubuntu
MAINTAINER Sagnik Banerjee <sagnikbanerjee15@gmail.com>

RUN apt-get -y update && \
	apt-get install -y --no-install-recommends python3 less wget unzip zip && \
	apt-get clean && \
	cd /usr/bin && \
	wget --no-check-certificate https://github.com/sagnikbanerjee15/scripts/archive/refs/heads/master.zip && \
	unzip master.zip && \
	cd scripts-master && \
	chmod a+x * && \
	mv * .. && \
	cd .. && \
	rm -rf scripts-master master.zip && \
    	apt-get --purge autoremove -y  ${PACKAGES}

