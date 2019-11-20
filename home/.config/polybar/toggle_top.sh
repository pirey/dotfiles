#!/bin/sh

pidfile=/tmp/polybar-top.pid
logfile=/tmp/polybar-top.log

if [ ! -f $pidfile ]; then
    polybar top >> $logfile 2>&1 &
    echo $! > $pidfile
else
    polybar-msg -p $(cat $pidfile) cmd toggle
fi
