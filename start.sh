#!/bin/bash

# Enabled i2c devices
modprobe i2c-dev

# Start app
python3 app.py
