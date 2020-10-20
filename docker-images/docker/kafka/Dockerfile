FROM ubuntu
RUN apt-get update
RUN apt install -y software-properties-common

RUN apt-get update && apt-get install -y vim htop iputils-ping telnetd net-tools tmux supervisor curl tar default-jre  nano iproute2 telnet


RUN apt-get update && apt-get install -y dbus systemd && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN find /etc/systemd -name '*.timer' | xargs rm -v

RUN systemctl set-default multi-user.target

COPY setup /sbin/

STOPSIGNAL SIGRTMIN+3

RUN mkdir /Downloads
RUN curl "https://downloads.apache.org/kafka/2.5.0/kafka_2.13-2.5.0.tgz" -o /Downloads/kafka1.tgz
#RUN cd Downloads
RUN mkdir /kafka && cd kafka &&  tar -xvzf /Downloads/kafka1.tgz --strip 1

COPY kafka.conf /etc/supervisor/conf.d/kafka.conf
COPY zookeeper.conf /etc/supervisor/conf.d/zookeeper.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
EXPOSE 9092 2181 3421
CMD ["/entrypoint.sh"]