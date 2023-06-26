#!/usr/bin/env bash

if [ -n "$(pgrep -u $UID -x ffmpeg)" ] || [ -n "$(pgrep -u $UID -x obs-ffmpeg-mux)" ]
then
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
    echo ""
fi
