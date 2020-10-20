#!/bin/bash
kill -9 $(pgrep -f "python forager.py --service singbet --worker balance")
source  /executable/env.sh
cd /forager
//.pyenv/shims/python forager.py --service singbet --worker balance --nworker 3