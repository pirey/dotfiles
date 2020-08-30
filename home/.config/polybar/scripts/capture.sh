#!/usr/bin/env bash

recording_pidfile=/tmp/recording.pid

if [ -f $recording_pidfile ]; then
    # simulate blinking text for indicator

    # by using timestamp
    stamp=$(date +%s)

    # use the stamp to alternate blinking
    if [ $((stamp%2)) -eq 0 ]; then
        echo "REC %{F#ff0000}●%{F-}"
    else
        echo "     "
    fi
else
    echo ""
fi
