#!/bin/sh

# Gives a dmenu prompt to mount unmounted drives and Android phones. If
# they're in /etc/fstab, they'll be mounted automatically. Otherwise, you'll
# be prompted to give a mountpoint from already existsing directories. If you
# input a novel directory, it will prompt you to create that directory.

getmount() { \
    [ -z "$chosen" ] && exit 1
    # shellcheck disable=SC2086
    mp="$(find $1 2>/dev/null | rofi -dmenu -i -p "Type in mount point.")" || exit 1
    [ "$mp" = "" ] && exit 1
    if [ ! -d "$mp" ]; then
        mkdiryn=$(printf "No\\nYes" | rofi -dmenu -i -p "$mp does not exist. Create it?") || exit 1
        [ "$mkdiryn" = "Yes" ] && (mkdir -p "$mp" || sudo -A mkdir -p "$mp" || pkexec mkdir -p "$mp")
    fi
}

mountusb() { \
    chosen="$(echo "$usbdrives" | rofi -dmenu -i -p "Mount which drive?")" || exit 1
    chosen="$(echo "$chosen" | awk '{print $1}')"
    sudo -A mount "$chosen" 2>/dev/null && notify-send "💻 USB mounting" "$chosen mounted." || \
        pkexec mount "$chosen" 2>/dev/null && notify-send "💻 USB mounting" "$chosen mounted." && exit 0
    alreadymounted=$(lsblk -nrpo "name,type,mountpoint" | awk '$3!~/\/boot|\/home$|SWAP/&&length($3)>1{printf "-not ( -path *%s -prune ) ",$3}')
    getmount "/mnt /media /mount /home -maxdepth 5 -type d $alreadymounted"
    partitiontype="$(lsblk -no "fstype" "$chosen")"
    case "$partitiontype" in
        "vfat") sudo -A mount -t vfat "$chosen" "$mp" -o rw,umask=0000 || pkexec mount -t vfat "$chosen" "$mp" -o rw,umask=0000;;
        *) sudo -A mount "$chosen" "$mp" || pkexec mount "$chosen" "$mp"; user="$(whoami)"; ug="$(groups | awk '{print $1}')"; sudo -A chown "$user":"$ug" "$mp";;
    esac
    notify-send "💻 USB mounting" "$chosen mounted to $mp."
}

mountandroid() { \
    if ! $(type simple-mtpfs >/dev/null 2>&1) ; then notify-send "simple-mtpfs not installed!" "Cannot mount android"; exit 1; fi

    chosen="$(echo "$anddrives" | rofi -dmenu -i -p "Which Android device?")" || exit 1
    chosen="$(echo "$chosen" | cut -d : -f 1)"
    getmount "$HOME -maxdepth 3 -type d"
    simple-mtpfs --device "$chosen" "$mp"
    echo "OK" | rofi -dmenu -i -p "Tap Allow on your phone if it asks for permission and then press enter" || exit 1
    simple-mtpfs --device "$chosen" "$mp"
    notify-send "🤖 Android Mounting" "Android device mounted to $mp."
}

asktype() { \
    choice="$(printf "USB\\nAndroid" | rofi -dmenu -i -p "Mount a USB drive or Android device?")" || exit 1
    case $choice in
        USB) mountusb ;;
        Android) mountandroid ;;
    esac
}

anddrives=$(simple-mtpfs -l 2>/dev/null)
# usbdrives="$(lsblk -rpo "name,type,size,mountpoint" | awk '$4==""{printf "%s (%s)\n",$1,$3}')"
usbdrives="$(lsblk -rpo "name,type,size,mountpoint" | awk '$4=="" && !$4 ~ "/dev/nvme0n"{printf "%s (%s)\n",$1,$3}')"

if [ -z "$usbdrives" ]; then
    [ -z "$anddrives" ] && notify-send "No USB drive or Android device detected" && exit
    msg="Android device(s) detected."
    echo "$msg"; notify-send "$msg"
    mountandroid
else
    if [ -z "$anddrives" ]; then
        msg="USB drive(s) detected."
        echo "$msg"; notify-send "$msg"
        mountusb
    else
        msg="Mountable USB drive(s) and Android device(s) detected."
        echo "$msg"; notify-send "$msg"
        asktype
    fi
fi
