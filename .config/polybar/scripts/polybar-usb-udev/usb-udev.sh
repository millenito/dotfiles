#!/bin/sh

# https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-usb-udev
# Copy 95-usb.rules to /etc/udev/rules.d/95-usb.rules. Make sure that the paths in the file have been modified properly.
usb_print() {
    devices=$(lsblk -Jplno NAME,TYPE,RM,SIZE,MOUNTPOINT,VENDOR)
    output=""
    counter=0

    for unmounted in $(echo "$devices" | jq -r '.blockdevices[] | select(.type == "part") | select(.rm == true) | select(.mountpoint == null) | .name'); do
        unmounted=$(echo "$unmounted" | tr -d "[:digit:]")
        unmounted=$(echo "$devices" | jq -r '.blockdevices[] | select(.name == "'"$unmounted"'") | .vendor')
        unmounted=$(echo "$unmounted" | tr -d ' ')

        if [ $counter -eq 0 ]; then
            space=""
        else
            space="   "
        fi
        counter=$((counter + 1))

        output="$output$space#1 $unmounted"
    done

    for mounted in $(echo "$devices" | jq -r '.blockdevices[] | select(.type == "part") | select(.rm == true) | select(.mountpoint != null) | .size'); do
        if [ $counter -eq 0 ]; then
            space=""
        else
            space="   "
        fi
        counter=$((counter + 1))

        output="$output$space#2 $mounted"
    done

    echo "$output"
}

usb_update() {
    pid=$(cat "$path_pid")

    if [ "$pid" != "" ]; then
        kill -10 "$pid"
    fi
}

path_pid="/tmp/polybar-system-usb-udev.pid"

case "$1" in
    --update)
        usb_update
        ;;
    --mount)
        devices=$(lsblk -Jplno NAME,TYPE,RM,MOUNTPOINT)

        for mount in $(echo "$devices" | jq -r '.blockdevices[] | select(.type == "part") | select(.rm == true) | select(.mountpoint == null) | .name'); do
            # udisksctl mount --no-user-interaction -b "$mount"

            # mountpoint=$(udisksctl mount --no-user-interaction -b $mount)
            # mountpoint=$(echo $mountpoint | cut -d " " -f 4 | tr -d ".")
            # terminal -e "bash -lc 'filemanager $mountpoint'"

            mountpoint=$(udisksctl mount --no-user-interaction -b "$mount")
            mountpoint=$(echo "$mountpoint" | cut -d " " -f 4 | tr -d ".")
            $TERMINAL -e "bash -lc 'mc $mountpoint'" &
        done

        usb_update
        ;;
    --unmount)
        devices=$(lsblk -Jplno NAME,TYPE,RM,MOUNTPOINT)

        for unmount in $(echo "$devices" | jq -r '.blockdevices[] | select(.type == "part") | select(.rm == true) | select(.mountpoint != null) | .name'); do
            udisksctl unmount --no-user-interaction -b "$unmount"
            udisksctl power-off --no-user-interaction -b "$unmount"
        done

        usb_update
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            usb_print

            sleep 60 &
            wait
        done
        ;;
esac
