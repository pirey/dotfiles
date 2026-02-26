#!/bin/sh
# rund — minimal project-scoped background runner (POSIX sh, XDG-aware)

STATE_BASE="${XDG_STATE_HOME:-$HOME/.local/state}/rund"
PROJECT_ID=$(pwd | cksum | awk '{print $1}')
STATE_DIR="$STATE_BASE/$PROJECT_ID"

mkdir -p "$STATE_DIR"

usage() {
    echo "usage:"
    echo "  rund -- command..."
    echo "  rund run <name> -- command..."
    echo "  rund ls [-a|-g]"
    echo "  rund stop <name>"
    echo "  rund stop -a"
    echo "  rund stop -g"
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

    setsid sh -c "$*" >>"$STATE_DIR/$name.log" 2>&1 &
    pid=$!

    echo "$pid" > "$STATE_DIR/$name.pid"
    echo "$*" > "$STATE_DIR/$name.cmd"
}

list_dir() {
    dir="$1"
    project=$(basename "$dir")
    set -- "$dir"/*.pid
    [ "$1" = "$dir/*.pid" ] && return
    for p in "$@"; do
        n=$(basename "$p" .pid)
        pid=$(cat "$p")
        cmd=$(cat "$dir/$n.cmd")
        printf "%-12s %-20s %-8s %s\n" "$project" "$n" "$pid" "$cmd"
    done
}

# implicit run: rund -- command...
if [ "$1" = "--" ]; then
    shift
    [ $# -gt 0 ] || usage
    base=$(printf "%s\n" "$*" | cksum | awk '{print $1}')
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
        printf "%-12s %-20s %-8s %s\n" PROJECT NAME PID COMMAND
        case "$1" in
            -g)
                set -- "$STATE_BASE"/*
                [ "$1" = "$STATE_BASE/*" ] && exit 0
                for d in "$@"; do
                    [ -d "$d" ] && list_dir "$d"
                done
                ;;
            -a|"")
                list_dir "$STATE_DIR"
                ;;
            *)
                usage
                ;;
        esac
        ;;

    stop)
        case "$1" in
            -a)
                set -- "$STATE_DIR"/*.pid
                [ "$1" = "$STATE_DIR/*.pid" ] && exit 0
                for p in "$@"; do
                    kill "$(cat "$p")" 2>/dev/null
                    rm -f "$p"
                done
                ;;
            -g)
                set -- "$STATE_BASE"/*/*.pid
                [ "$1" = "$STATE_BASE/*/*.pid" ] && exit 0
                for p in "$@"; do
                    kill "$(cat "$p")" 2>/dev/null
                    rm -f "$p"
                done
                ;;
            *)
                [ $# -eq 1 ] || usage
                pidfile="$STATE_DIR/$1.pid"
                [ -f "$pidfile" ] || exit 1
                kill "$(cat "$pidfile")" 2>/dev/null
                rm -f "$pidfile"
                ;;
        esac
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
