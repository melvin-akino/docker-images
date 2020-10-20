FROM ubuntu
RUN apt-get update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php


RUN  apt-get update && apt-get install -y  php7.3 php7.3-cli php7.3-xml php7.3-soap php7.3-xmlrpc php7.3-mbstring php7.3-json php7.3-gd  php7.3-mbstring php7.3-pgsql  php7.3-xml php7.3-soap php7.3-xmlrpc php7.3-mbstring php7.3-curl php7.3-json php7.3-gd  php7.3-mbstring php7.3-zip   php7.3-bcmath php7.3-dev php-redis php7.3-sqlite3 php-pear libyaml-dev 

RUN  curl -sS https://getcomposer.org/installer |php
RUN  mv composer.phar /usr/local/bin/composer

RUN apt-get update \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get -y install nodejs wget

RUN apt-get update \
    && apt-get -y install git \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
 # MONITORING TOOL
RUN mkdir /downloads && cd /downloads/ \
	&& wget https://github.com/prometheus/node_exporter/releases/download/v0.18.0/node_exporter-0.18.0.linux-amd64.tar.gz \
	&& tar xzf node_exporter-0.18.0.linux-amd64.tar.gz \
	&&  cp node_exporter-0.18.0.linux-amd64/node_exporter /usr/local/bin/ \
	&& curl -fSL -o promtail.gz "https://github.com/grafana/loki/releases/download/v1.4.1/promtail-linux-amd64.zip" \
	&&  gunzip promtail.gz \
	&& cp promtail /usr/local/bin/promtail \
	&& chmod a+x /usr/local/bin/promtail
#cronjob
RUN apt-get update && apt-get install cron

#timezone
RUN apt-get update && apt-get install -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

COPY config-promtail.yml /usr/local/bin/config-promtail.yml
COPY promtail.service /etc/systemd/system/promtail.service
#RUN pecl install  swoole

RUN apt-get update && apt-get install -y librdkafka-dev nano vim htop iputils-ping telnetd net-tools tmux supervisor
#add cronjob
RUN apt-get update && apt-get install cron

#RUN pecl install  rdkafka-3.0.3
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

# RUN pecl install  swoole
RUN mkdir /swoole && cd /swoole \
	&&  git clone https://github.com/swoole/swoole-src.git . \
	&& git checkout v4.4.14 \
	&& phpize \
	&& ./configure --enable-openssl --enable-sockets --enable-http2 \
	&& make \
	&& make install

RUN mkdir /swoole_async && cd /swoole_async  \
	&& git clone https://github.com/swoole/async-ext.git . \
	&& git checkout v4.4.14 \
	&& phpize \
	&& ./configure \
	&& make -j 4 \
	&& make install

COPY 100-swoole.ini /etc/php/7.3/cli/conf.d/100-swoole.ini

COPY 200-rdkafka.ini /etc/php/7.3/cli/conf.d/200-rdkafka.ini
COPY 100-swoole_async.ini /etc/php/7.3/cli/conf.d/100-swoole_async.ini

RUN service apache2 stop

COPY node_exporter.conf /etc/supervisor/conf.d/node_exporter.conf
COPY scraping-odds-worker.conf /etc/supervisor/conf.d/scraping-odds-worker.conf
COPY scraping_odds.conf /etc/supervisor/conf.d/scraping_odds.conf
COPY scraping_provider_events.conf /etc/supervisor/conf.d/scraping_provider_events.conf
COPY scraping-provider-events-worker.conf /etc/supervisor/conf.d/scraping-provider-events-worker.conf
COPY promtail.conf /etc/supervisor/conf.d/promtail.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

WORKDIR "/var/www/html"
RUN rm "/var/www/html/index.html"

EXPOSE 9100

RUN ["/bin/bash", "-c", "echo hello all in one string"]
CMD ["/entrypoint.sh"]


