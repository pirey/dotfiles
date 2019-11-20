#!/bin/sh

pidfile=/tmp/polybar-bottom.pid
logfile=/tmp/polybar-bottom.log

if [ ! -f $pidfile ]; then
    polybar bottom >> $logfile 2>&1 &
    echo $! > $pidfile
else
    polybar-msg -p $(cat $pidfile) cmd toggle
fi
