#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch top and bottom bar
polybar top >>/tmp/polybar-top.log 2>&1 &
echo $! >/tmp/polybar-top.pid

polybar bottom >>/tmp/polybar-bottom.log 2>&1 &
echo $! >/tmp/polybar-bottom.pid
