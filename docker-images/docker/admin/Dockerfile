# Download base image ubuntu 20.04
FROM ubuntu:20.04

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php

RUN  apt-get update && apt-get install -y  php7.3 php7.3-cli php7.3-xml php7.3-soap php7.3-xmlrpc php7.3-mbstring php7.3-json php7.3-gd  php7.3-mbstring php7.3-pgsql  php7.3-xml php7.3-soap php7.3-xmlrpc php7.3-mbstring php7.3-curl php7.3-json php7.3-gd  php7.3-mbstring php7.3-zip   php7.3-bcmath php7.3-dev php-redis php7.3-sqlite3 php-pear libyaml-dev php7.3-fpm 

RUN  curl -sS https://getcomposer.org/installer |php
RUN  mv composer.phar /usr/local/bin/composer

RUN apt-get update \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get -y install nodejs wget

RUN apt-get update \
    && apt-get -y install git \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN apt-get update && apt-get install -y librdkafka-dev nano vim htop iputils-ping telnetd net-tools tmux xz-utils dnsutils snapd fuse

#add cronjob
RUN apt-get update && apt-get install cron

RUN apt-get install -y supervisor nginx

#timezone
RUN apt-get update && apt-get install -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

#certbot
RUN apt-get update
RUN apt-get install -y certbot python3-certbot-nginx

# MONITORING TOOL
RUN mkdir /downloads && cd /downloads/ \
    && wget https://github.com/prometheus/node_exporter/releases/download/v0.18.0/node_exporter-0.18.0.linux-amd64.tar.gz \
    && tar xzf node_exporter-0.18.0.linux-amd64.tar.gz \
    &&  cp node_exporter-0.18.0.linux-amd64/node_exporter /usr/local/bin/ \
    && curl -fSL -o promtail.gz "https://github.com/grafana/loki/releases/download/v1.4.1/promtail-linux-amd64.zip" \
    &&  gunzip promtail.gz \
    && cp promtail /usr/local/bin/promtail \
    && chmod a+x /usr/local/bin/promtail

COPY config-promtail.yml /usr/local/bin/config-promtail.yml
COPY promtail.service /etc/systemd/system/promtail.service

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
RUN npm config set fund false 

RUN mkdir /rdkafka && cd  /rdkafka \
    && git clone https://github.com/edenhill/librdkafka.git . \
    &&  ./configure \
    && make \
    && make install
RUN mkdir /php-rdkafka  && cd /php-rdkafka \
    && git clone https://github.com/arnaud-lb/php-rdkafka.git . \
    && phpize \
    && ./configure \
    &&  make all -j 5 \
    && make install


COPY 200-rdkafka.ini /etc/php/7.3/cli/conf.d/200-rdkafka.ini
COPY 200-rdkafka.ini /etc/php/7.3/fpm/conf.d/200-rdkafka.ini

#RUN service apache2 stop
COPY nginx.conf /etc/nginx/sites-available/default
COPY node_exporter.conf /etc/supervisor/conf.d/node_exporter.conf
COPY StartKafaBalanceMonitoring.conf /etc/supervisor/conf.d/StartKafaBalanceMonitoring.conf
COPY promtail.conf /etc/supervisor/conf.d/promtail.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
COPY 502.html /var/www/502.html
WORKDIR "/var/www/html"

RUN rm "/var/www/html/index.nginx-debian.html"
RUN ["/bin/bash", "-c", "echo hello all in one string"]

CMD ["/entrypoint.sh"]
EXPOSE 80 443
