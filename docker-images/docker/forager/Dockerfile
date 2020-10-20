FROM ubuntu
RUN apt-get update
RUN apt install -y software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa



RUN apt-get update \
    && apt-get -y install git wget curl  \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
#timezone
RUN apt-get update && apt-get install -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

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
COPY promtail.conf /etc/supervisor/conf.d/promtail.conf

#cronjob
RUN apt-get update && apt-get install cron


RUN apt-get update && apt-get install -y librdkafka-dev nano vim htop iputils-ping telnetd net-tools tmux supervisor 

#REDIS
ENV REDIS_VERSION=4.0.9 \
    REDIS_USER=redis \
    REDIS_DATA_DIR=/var/lib/redis \
    REDIS_LOG_DIR=/var/log/redis

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server \
 && sed 's/^bind /# bind /' -i /etc/redis/redis.conf \
 && sed 's/^logfile /# logfile /' -i /etc/redis/redis.conf \
 && sed 's/^daemonize yes/daemonize no/' -i /etc/redis/redis.conf \
 && sed 's/^protected-mode yes/protected-mode no/' -i /etc/redis/redis.conf \
 && sed 's/^# unixsocket /unixsocket /' -i /etc/redis/redis.conf \
 && sed 's/^# unixsocketperm 700/unixsocketperm 777/' -i /etc/redis/redis.conf \
 && rm -rf /var/lib/apt/lists/*
#COPY redis.conf /etc/redis/redis.conf


#PYTHON

 RUN   apt-get update && \
    apt-get -y install \
        git make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
        libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils \
        libffi-dev liblzma-dev libcurl4-openssl-dev 
RUN git clone git://github.com/yyuu/pyenv.git .pyenv
RUN git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
ENV HOME  /
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv install 3.6.8
RUN pyenv global 3.6.8
RUN pip install --upgrade pip
#COMMANDS
RUN mkdir /executable
COPY executable/ /executable
COPY command/hg_balance.conf /etc/supervisor/conf.d/hg_balance.conf
COPY command/hg_bet.conf /etc/supervisor/conf.d/hg_bet.conf
COPY command/hg_heartbeat.conf /etc/supervisor/conf.d/hg_heartbeat.conf
COPY command/hg_minmax.conf  /etc/supervisor/conf.d/hg_minmax.conf
COPY command/hg_odds.conf    /etc/supervisor/conf.d/hg_odds.conf
COPY command/hg_orders.conf /etc/supervisor/conf.d/hg_orders.conf
COPY command/hg_session.conf /etc/supervisor/conf.d/hg_session.conf
COPY command/hg_settlement.conf /etc/supervisor/conf.d/hg_settlement.conf

RUN chmod 755 -R /executable


COPY node_exporter.conf /etc/supervisor/conf.d/node_exporter.conf

RUN mkdir /forager
RUN mkdir /scraper
WORKDIR /forager

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh


EXPOSE 9100

RUN ["/bin/bash", "-c", "echo hello all in one string"]
CMD ["/entrypoint.sh"]


