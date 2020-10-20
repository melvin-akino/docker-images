#!/usr/bin/env bash
#cd /frontend
#npm install 
#npm run prod
#php bin/laravels start
#!/bin/bash
#P=$(hostname -I)

#cp /etc/hosts /etc/hosts2
#sed -i "s/127.0.0.1/$P/g" /etc/hosts2
#echo "" > /etc/hosts
#cat /etc/hosts2 >> /etc/hosts
if [ ! -z "$ADVERTISED_HOST" ]; then
	echo $ADVERTISED_HOST >> test.txt
	sed -r -i 's/^(#)(advertised.listeners)/\2/g' /kafka/config/server.properties
	sed -r -i "s/your.host.name/$ADVERTISED_HOST/g" /kafka/config/server.properties



fi
echo "delete.topic.enable = true" >> /kafka/config/server.properties
service supervisor start
tail -f /dev/null