FROM php:7.4.2-cli

RUN apt-get update && apt-get install vim -y && \
    apt-get install openssl -y && \
    apt-get install libssl-dev -y && \
    apt-get install wget -y && \
    apt-get install git -y && \
    apt-get install procps -y && \
    apt-get install libpq-dev -y && \
    apt-get install htop -y && \
    apt-get install librdkafka-dev -y && \
    apt-get install supervisor -y

RUN apt-get update

RUN  curl -sS https://getcomposer.org/installer |php
RUN  mv composer.phar /usr/local/bin/composer

#RUN pecl install
RUN cd /tmp && git clone https://github.com/edenhill/librdkafka.git && \
	cd librdkafka && \
	./configure && \
	make && make install

RUN cd /tmp && git clone https://github.com/arnaud-lb/php-rdkafka.git && \
	cd php-rdkafka && \
    phpize && \
	./configure && \
	make && make install

# RUN pecl install  swoole
RUN cd /tmp && git clone https://github.com/swoole/swoole-src.git && \
    cd swoole-src && \
    git checkout v4.7.0 && \
    phpize && \
    ./configure && \
    make && make install

RUN cd /tmp && git clone https://github.com/swoole/ext-postgresql.git && \
    cd ext-postgresql && \
    git checkout v4.6.1 && \
    phpize && \
    ./configure && \
    make && make install

RUN cd /tmp && git clone https://github.com/phpredis/phpredis.git && \
    cd phpredis && \
    phpize && \
    ./configure && \
    make && make install

RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
    echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini
RUN echo "extension=swoole_postgresql.so" >> /usr/local/etc/php/conf.d/swoole.ini

RUN touch /usr/local/etc/php/conf.d/rdkafka.ini && \
    echo "extension=rdkafka.so" > /usr/local/etc/php/conf.d/rdkafka.ini

RUN echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

RUN docker-php-ext-install opcache bcmath pcntl

COPY docker/php/conf.d/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64
RUN chmod +x /usr/local/bin/dumb-init

RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "php"]
