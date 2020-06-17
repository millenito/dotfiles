#!/bin/sh

# A dmenu prompt to unmount drives.
# Provides you with mounted partitions, select one to unmount.
# Drives mounted at /, /boot and /home will not be options to unmount.

unmountusb() {
    [ -z "$drives" ] && exit
    chosen="$(echo "$drives" | rofi -dmenu -i -p "Unmount which drive?")" || exit 1
    chosen="$(echo "$chosen" | awk '{print $1}')"
    [ -z "$chosen" ] && exit
    sudo -A umount "$chosen" && notify-send "💻 USB unmounting" "$chosen unmounted." || \
        pkexec umount "$chosen" && notify-send "💻 USB unmounting" "$chosen unmounted."
}

unmountandroid() { \
    chosen="$(awk '/simple-mtpfs/ {print $2}' /etc/mtab | rofi -dmenu -i -p "Unmount which device?")" || exit 1
    [ -z "$chosen" ] && exit
    sudo -A umount -l "$chosen" && notify-send "🤖 Android unmounting" "$chosen unmounted." || \
        pkexec umount -l "$chosen" && notify-send "🤖 Android unmounting" "$chosen unmounted."
}

asktype() { \
    choice="$(printf "USB\\nAndroid" | rofi -dmenu -i -p "Unmount a USB drive or Android device?")" || exit 1
    case "$choice" in
        USB) unmountusb ;;
        Android) unmountandroid ;;
    esac
}

drives=$(lsblk -nrpo "name,type,size,mountpoint" | awk '$4!~/\/boot|\/home$|SWAP/&&length($4)>1{printf "%s (%s)\n",$4,$3}')

if ! grep simple-mtpfs /etc/mtab; then
    [ -z "$drives" ] && echo "No drives to unmount." &&  exit
    msg="Unmountable USB drive detected."
    echo "$msg"; notify-send "$msg"
    unmountusb
else
    if [ -z "$drives" ]
    then
        msg="Unmountable Android device detected."
        echo "$msg"; notify-send "$msg"
        unmountandroid
    else
        msg="Unmountable USB drive(s) and Android device(s) detected."
        echo "$msg"; notify-send "$msg"
        asktype
    fi
fi
