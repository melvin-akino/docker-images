#!/bin/sh
service php7.3-fpm stop
service php7.3-fpm start
service nginx start
service supervisor start
tail -f /dev/null
