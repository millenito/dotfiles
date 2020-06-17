#!/usr/bin/env sh

# Send notification with notify-send if battery is below 15%
# for use in crontab

STATUS=$(acpi --battery | grep "Battery 0" | grep Discharging)
IMAGE="/usr/share/icons/Papirus-Dark/16x16/panel/xfce4-battery-critical.svg"

if [ -n "$STATUS" ]; then
    echo "$STATUS" | awk -F, '/Discharging/ { if (int($2) < 15) print }' | xargs -ri env DISPLAY=:0 notify-send -a "Battery status" -u critical -i "$IMAGE" -t 3000 "{}\nBattery Low."
fi
