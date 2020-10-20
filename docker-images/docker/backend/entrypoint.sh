#!/usr/bin/env bash
service supervisor start
tail -f /dev/null
#supervisorctl update
#supervisorctl start all