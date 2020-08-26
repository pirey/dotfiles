#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## Github : @adi1090x
## Reddit : @adi1090x

rofi_command="rofi -theme themes/powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown="襤"
reboot="ﰇ"
lock=""
suspend="鈴"
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        . ~/.config/i3/scripts/fuzzy_lock.sh
        ;;
    $suspend)
        # mpc -q pause
        # amixer set Master mute
        systemctl suspend
        ;;
    $logout)
        i3-msg exit
        ;;
esac

