FROM ubuntu:16.04

MAINTAINER ZeroC, Inc. docker-maintainers@zeroc.com

ENV ICEGRID_VERSION 3.7.2

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv B6391CB2CFBA643D \
    && echo "deb http://download.zeroc.com/Ice/3.7/ubuntu16.04 stable main" >> /etc/apt/sources.list.d/ice.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
            zeroc-icegrid=${ICEGRID_VERSION}-* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
RUN cd /etc && ls -l 
RUN mkdir /etc/zeroc 
RUN chmod -R 755 /etc/zeroc 
RUN cd /etc/zeroc && ls -l 
RUN cp /etc/icegridregistry.conf /etc/zeroc/. 
RUN cd /etc/zeroc && ls -l
RUN chmod 755 /etc/zeroc/icegridregistry.conf && cd /etc/zeroc && ls -l
RUN cat /etc/zeroc/icegridregistry.conf

EXPOSE 4061 4062

VOLUME ["/var/lib/ice/icegrid"]
VOLUME ["/etc/zeroc"]

ENTRYPOINT ["/usr/bin/icegridregistry", "--Ice.Config=/etc/zeroc/icegridregistry.conf", "--IceGrid.Registry.LMDB.Path=/var/lib/ice/icegrid"]
