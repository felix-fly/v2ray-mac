#!/bin/sh

# disable pac
/usr/sbin/networksetup -setautoproxystate "Wi-Fi" off

# kill process
pkill -f "python -m SimpleHTTPServer 88"
pkill -f "./v2ray"
