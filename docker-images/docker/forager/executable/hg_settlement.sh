#!/bin/bash
kill -9 $(pgrep -f "python forager.py --service singbet --worker settlement")
source  /executable/env.sh
cd /forager
//.pyenv/shims/python forager.py --service singbet --worker settlement --nworker 3