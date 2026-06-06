#!/bin/sh
set -e

STATUS_FILE="${STATUS_FILE:-/tmp/opencode-active}"
IDLE_TIMEOUT=30

cleanup() {
    [ -n "$CAFF_PID" ] && kill "$CAFF_PID" 2>/dev/null
    exit 0
}
trap cleanup INT TERM

if [ ! -f "$STATUS_FILE" ]; then
    echo "opencode status file not found ($STATUS_FILE), exiting."
    exit 1
fi

echo "Monitoring $STATUS_FILE for opencode activity..."

CAFF_PID=
LAST_ACTIVE=0

while true; do
    if [ -f "$STATUS_FILE" ]; then
        MTIME=$(stat -f %m "$STATUS_FILE" 2>/dev/null || echo 0)
        NOW=$(date +%s)
        AGE=$((NOW - MTIME))
        if [ "$AGE" -lt "$IDLE_TIMEOUT" ]; then
            LAST_ACTIVE=$NOW
        else
            LAST_ACTIVE=0
        fi
    else
        if [ -n "$CAFF_PID" ]; then
            kill "$CAFF_PID" 2>/dev/null
        fi
        exit 0
    fi

    NOW=$(date +%s)
    if [ $((NOW - LAST_ACTIVE)) -lt "$IDLE_TIMEOUT" ]; then
        if [ -z "$CAFF_PID" ] || ! kill -0 "$CAFF_PID" 2>/dev/null; then
            caffeinate &
            CAFF_PID=$!
        fi
    else
        if [ -n "$CAFF_PID" ]; then
            kill "$CAFF_PID" 2>/dev/null
        fi
        CAFF_PID=
    fi

    sleep 5
done
