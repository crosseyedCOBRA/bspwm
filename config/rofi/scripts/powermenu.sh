#!/bin/sh
# rofi power-menu backend: `rofi -show power-menu -modi power-menu:this-script`
case "$1" in
    "")
        printf 'Lock\nLogout\nSuspend\nReboot\nShutdown\n'
        ;;
    "Lock")     loginctl lock-session ;;
    "Logout")   bspc quit ;;
    "Suspend")  systemctl suspend ;;
    "Reboot")   systemctl reboot ;;
    "Shutdown") systemctl poweroff ;;
esac
