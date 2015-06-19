# DOCKER-VERSION 0.8.1

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

ADD ./lib/apt/sources.list /etc/apt/sources.list
RUN apt-get update -y; apt-get upgrade -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update -y; apt-get upgrade -y
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y curl oracle-java8-installer oracle-java8-set-default supervisor pwgen
RUN apt-get install -y rsync openssh-server
RUN mkdir -p /var/run/sshd

# You'll need a craftbukkit jar and optionally a spigot jar
COPY ./lib/*.jar /usr/local/etc/minecraft/
COPY ./lib/supervisor/supervisord.conf /etc/supervisor/
COPY ./lib/supervisor/conf.d/minecraft.conf /etc/supervisor/conf.d/
COPY ./lib/minecraft/* /usr/local/etc/minecraft/

COPY ./lib/eula.txt /usr/local/etc/minecraft/eula.txt

# script needed to work around docker limitations
COPY ./lib/scripts/docker-start.sh /usr/local/etc/minecraft/

# either copy your pubkey to root's .ssh/authorized_keys or this
RUN sed -i 's/^PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

# minecraft port
EXPOSE 25565

# ssh port
EXPOSE 22

VOLUME /mnt/minecraft
WORKDIR /usr/local/etc/minecraft

CMD ["./docker-start.sh"]
