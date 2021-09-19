#!/usr/bin/env sh

# disable multi monitors before launching osu
if [ $(xrandr | grep -v "disconnected" | grep "HDMI" | wc -l) -eq 1 ]; then
    xrandr --output HDMI-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1-1 --off
fi

# Run OpenTabletDriver
/usr/bin/opentabletdriver &

# Run osu! then go back to using multiple monitors and kill OpenTabletDriver
lutris lutris:rungameid/1 && xrandr --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal && pkill -f "OpenTabletDrive"
