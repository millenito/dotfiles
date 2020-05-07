#!/usr/bin/env sh

if [ $(xrandr | grep -v "disconnected" | grep "HDMI" | wc -l) -eq 1 ]; then
    xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal
else
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off
fi

$SCRIPTS/launch_polybar.sh
$SCRIPTS/keyboard_scripts.sh
