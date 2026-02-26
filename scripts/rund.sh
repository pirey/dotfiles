#!/bin/sh
# rund — minimal project-scoped background runner (POSIX sh, XDG-aware)

# XDG state base
STATE_BASE="${XDG_STATE_HOME:-$HOME/.local/state}"
PROJECT_ID=$(pwd | cksum | awk '{print $1}')
STATE_DIR="$STATE_BASE/rund/$PROJECT_ID"

mkdir -p "$STATE_DIR"

usage() {
    echo "usage:"
    echo "  rund -- command..."
    echo "  rund run <name> -- command..."
    echo "  rund ls"
    echo "  rund stop <name>"
    echo "  rund clean"
    echo "  rund attach <name>"
    exit 1
}

sanitize_name() {
    printf "%s\n" "$1" | tr 'A-Z' 'a-z' | sed 's/[^a-z0-9]/_/g'
}

unique_name() {
    base="$1"
    name="$base"
    i=2
    while [ -f "$STATE_DIR/$name.pid" ]; do
        name="${base}-${i}"
        i=$((i + 1))
    done
    printf "%s\n" "$name"
}

run_cmd() {
    name="$1"
    shift

    [ "$1" = "--" ] || usage
    shift

    pidfile="$STATE_DIR/$name.pid"
    cmdfile="$STATE_DIR/$name.cmd"
    logfile="$STATE_DIR/$name.log"

    setsid sh -c "$*" >>"$logfile" 2>&1 &
    pid=$!

    echo "$pid" > "$pidfile"
    echo "$*" > "$cmdfile"
}

# implicit run: rund -- command...
if [ "$1" = "--" ]; then
    shift
    [ $# -gt 0 ] || usage

    raw="$*"
    base=$(sanitize_name "$raw")
    [ -n "$base" ] || base="proc"

    name=$(unique_name "$base")
    run_cmd "$name" -- "$@"
    exit 0
fi

cmd="$1"
shift || true

case "$cmd" in
    run)
        [ $# -ge 3 ] || usage
        name=$(sanitize_name "$1")
        name=$(unique_name "$name")
        shift
        run_cmd "$name" "$@"
        ;;

    ls)
        printf "%-20s %-8s %s\n" NAME PID COMMAND
        set -- "$STATE_DIR"/*.pid
        [ "$1" = "$STATE_DIR/*.pid" ] && exit 0
        for p in "$@"; do
            n=$(basename "$p" .pid)
            pid=$(cat "$p")
            cmdline=$(cat "$STATE_DIR/$n.cmd")
            printf "%-20s %-8s %s\n" "$n" "$pid" "$cmdline"
        done
        ;;

    stop)
        [ $# -eq 1 ] || usage
        pidfile="$STATE_DIR/$1.pid"
        [ -f "$pidfile" ] || exit 1
        kill "$(cat "$pidfile")" 2>/dev/null
        rm -f "$pidfile"
        ;;

    clean)
        set -- "$STATE_DIR"/*.pid
        [ "$1" = "$STATE_DIR/*.pid" ] && exit 0
        for p in "$@"; do
            pid=$(cat "$p")
            kill -0 "$pid" 2>/dev/null || rm -f "$p"
        done
        ;;

    attach)
        [ $# -eq 1 ] || usage
        tail -f "$STATE_DIR/$1.log"
        ;;

    *)
        usage
        ;;
esac
