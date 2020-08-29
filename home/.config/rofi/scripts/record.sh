#!/usr/bin/env bash

action=$1

pidfile=/tmp/record.pid

record_screencast () {
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
        "$HOME/Videos/recording/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &

    echo $! > ~/.recordingpid
}

record_video () {
    ffmpeg \
        -f x11grab \
        -framerate 30 \
        -s $(xrandr | grep '*' | awk '{print $1;}') \
        -i :0.0+0,0 \
        -c:v libx264 \
        "$HOME/Videos/recording/recording-$(date '+%y%m%d-%H%M-%S').mp4" &

    echo $! > $pidfile
}

record_audio () {
    ffmpeg \
        -f pulse -i default \
        -c:a flac \
        "$HOME/Music/recording/audio-$(date '+%y%m%d-%H%M-%S').flac" &

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
    yes="YES"
    no="NO"
    response=$(echo -e "$no\n$yes" | rofi -dmenu -p "STOP RECORDING?")

    if [[ "$response" = "$yes" ]]; then
        stop_recording
    fi
}

main () {
    if [[ -f $pidfile ]]; then
        confirm_end
        exit
    fi

    screencast="SCREENCAST"
    video="VIDEO"
    audio="AUDIO"
    choice=$(echo -e "$screencast\n$video\n$audio" | rofi -dmenu -p "RECORD")

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
