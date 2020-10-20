#!/usr/bin/env bash
#cd /frontend
#npm install 
#npm run prod
#php bin/laravels start
#!/bin/bash
service apache2 stop
service nginx start
service supervisor start
tail -f /dev/null