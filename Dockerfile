FROM phusion/baseimage:0.9.15
MAINTAINER pducharme@me.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

# Common Deps
RUN apt-get -y install curl software-properties-common

# Oracle Java 8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN add-apt-repository ppa:webupd8team/java && apt-get update
RUN apt-get -y install oracle-java8-installer
RUN update-java-alternatives -s java-8-oracle
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA8_HOME /usr/lib/jvm/java-8-oracle

# MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
ADD mongodb.list /etc/apt/sources.list.d/mongodb.list
RUN apt-get update && apt-get -y install mongodb-server

# UniFi 4.x
RUN apt-get -y install jsvc
RUN curl -L -o unifi_sysvinit_all.deb http://dl.ubnt.com/unifi/4.2.0/unifi_sysvinit_all.deb
RUN dpkg --install unifi_sysvinit_all.deb

# Wipe out auto-generated data
RUN rm -rf /var/lib/unifi/*

EXPOSE 8080 8081 8443 8843 8880

VOLUME ["/var/lib/unifi"]

WORKDIR /var/lib/unifi

ADD run.sh /run.sh
RUN chmod 755 /run.sh

CMD ["/run.sh"]
