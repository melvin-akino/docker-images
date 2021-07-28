#!/bin/sh
service supervisor start
/usr/local/bin/dumb-init -- php
