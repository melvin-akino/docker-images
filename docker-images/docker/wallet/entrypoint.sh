service apache2 stop
systemctl restart php7.3-fpm.service
service nginx start
service supervisor start
tail -f /dev/null
