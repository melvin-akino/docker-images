#!/bin/bash
kill -9 $(pgrep -f "python forager.py --service singbet --worker heartbeat")
source  /executable/env.sh
cd /forager
//.pyenv/shims/python forager.py --service singbet --worker heartbeat --nworker 3