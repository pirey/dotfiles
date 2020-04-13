#!/bin/sh

for m in $(polybar --list-monitors | cut -d":" -f1); do
    pidfile=/tmp/polybar-bottom-${m}.pid
    logfile=/tmp/polybar-bottom-${m}.log

    if [ ! -f $pidfile ]; then
        MONITOR=$m polybar bottom >> $logfile 2>&1 &
        echo $! > $pidfile
    else
        polybar-msg -p $(cat $pidfile) cmd toggle
    fi
done

