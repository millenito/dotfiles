#!/bin/sh
# Make windows ratio 60:40 when there's only 2 windows and 50:50 for the next one
bspc subscribe node_remove node_add node_transfer desktop_focus monitor_focus | while read -r line; do
    if [ $( bspc query -N -d focused.local | wc -l) -eq 1 ]; then
        bspc config split_ratio 0.60
    else
        bspc config split_ratio 0.50
    fi  
done
