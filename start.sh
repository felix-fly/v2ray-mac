#!/bin/sh

BASE=$(cd "$(dirname "$0")"; pwd)
cd $BASE

# start a http server
python -m SimpleHTTPServer 88 > /dev/null 2>&1 &

# set pac
/usr/sbin/networksetup -setautoproxyurl "Wi-Fi" "http://127.0.0.1:88/auto.pac"
/usr/sbin/networksetup -setautoproxystate "Wi-Fi" on

# start v2ray
./v2ray > /dev/null 2>&1 &
