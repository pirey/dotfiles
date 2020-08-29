#!/usr/bin/env bash

recording_pidfile=/tmp/recording.pid

if [ -f $recording_pidfile ]; then
    echo "REC ●"
else
    echo ""
fi
