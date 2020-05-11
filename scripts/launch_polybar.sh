#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
# polybar bar -r &
if type xrandr; then
    for i in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$i polybar top -r &
        MONITOR=$i polybar bottom -r &
    done
else
    polybar top -r &
    polybar bottom -r &
fi

# Hide polybar tray
hideIt.sh --name '^Polybar tray window$' --region 0x1080+10+-40
