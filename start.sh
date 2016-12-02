#!/bin/bash

# Enabled i2c devices
modprobe i2c-dev

# add path to the installed vcgencmd binary
PATH=${PATH}:/opt/vc/bin

# Start app
python3 app.py
