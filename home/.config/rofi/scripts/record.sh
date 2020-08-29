#!/usr/bin/env bash

action=$1

pidfile=/tmp/record.pid

rofi_command="rofi -theme themes/record.rasi"

record_screencast () {
    savedir="$HOME/Videos/screencasts"
    mkdir -p $savedir

    ffmpeg -y \
        -f x11grab \
        -framerate 30 \
        -s $(xrandr | grep '*' | awk '{print $1;}') \
        -i :0.0+0,0 \
        -f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
        -f pulse -i alsa_input.pci-0000_00_1b.0.analog-stereo \
        -filter_complex amix=inputs=2 \
        -c:a aac \
        -c:v libx264 -pix_fmt yuv420p -qp 18 -q:v 1 \
        -threads 4 \
        "$savedir/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &

    echo $! > ~/.recordingpid
}

record_video () {
    savedir="$HOME/Videos/recordings"
    mkdir -p $savedir

    ffmpeg \
        -f x11grab \
        -framerate 30 \
        -s $(xrandr | grep '*' | awk '{print $1;}') \
        -i :0.0+0,0 \
        -c:v libx264 -pix_fmt yuv420p -preset veryfast -q:v 1 \
        -threads 4 \
        "$savedir/recording-$(date '+%y%m%d-%H%M-%S').mp4" &

    echo $! > $pidfile
}

record_audio () {
    savedir="$HOME/Music/recordings"
    mkdir -p $savedir

    ffmpeg \
        -f pulse -i default \
        -c:a flac \
        "$savedir/recording-$(date '+%y%m%d-%H%M-%S').flac" &

    echo $! > $pidfile
}

stop_recording () {
    pid="$(cat $pidfile)"
    # kill with SIGTERM, allowing finishing touches.
    kill -15 "$pid"
    rm -f $pidfile
    exit
}

confirm_end () {
    yes=""
    no=""
    response=$(echo -e "$no\n$yes" | $rofi_command -dmenu -p "Stop Recording?")

    if [[ "$response" = "$yes" ]]; then
        stop_recording
    fi
}

main () {
    if [[ -f $pidfile ]]; then
        confirm_end
        exit
    fi

    screencast=""
    video=""
    audio=""
    choice=$(echo -e "$screencast\n$video\n$audio" | $rofi_command -dmenu -p "Start Recording")

    case "$choice" in
        $screencast) record_screencast;;
        $video) record_video;;
        $audio) record_audio;;
    esac
}

case "$action" in
  "screencast") record_screencast;;
  "audio") record_audio;;
  "video") record_video;;
  *) main;;
esac
