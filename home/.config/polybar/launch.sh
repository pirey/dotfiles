#!/bin/sh

# Terminate already running bar instances
rm -f /tmp/polybar*.pid
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch top bar
$HOME/.config/polybar/toggle_top.sh
