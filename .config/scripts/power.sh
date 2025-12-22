#!/usr/bin/env bash

set -e

MENU="rofi -dmenu -i -p Power"
OPTIONS="󰐥 Power Off\n󰜉 Reboot\n󰒲 Suspend\n󰍃 Logout\n󰗽 Lock"

CHOICE=$(printf "$OPTIONS" | $MENU)

case "$CHOICE" in
    "󰐥 Power Off")
        systemctl poweroff
        ;;
    "󰜉 Reboot")
        systemctl reboot
        ;;
    "󰒲 Suspend")
        systemctl suspend
        ;;
    "󰍃 Logout")
        swaymsg exit
        ;;
    "󰗽 Lock")
        if command -v swaylock >/dev/null 2>&1; then
            swaylock
        elif command -v loginctl >/dev/null 2>&1; then
            loginctl lock-session
        fi
        ;;
    *)
        exit 0
        ;;
esac
