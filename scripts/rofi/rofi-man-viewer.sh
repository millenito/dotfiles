#!/usr/bin/env sh
# Launch rofi with a list of all available man pages and opens the selected one with zathura

READER=/usr/bin/zathura

MANS=$(man -k .)

CHOOSEN=$(echo "$MANS" | rofi -dmenu -i -matching regex -p "Select man page ($(echo "$MANS" | wc -l))")

if ! [ -x $(command -v "$READER") ]; then
    echo "$READER" not installed
    exit 1
else
    [ -z "$CHOOSEN" ] && exit
    echo "$CHOOSEN" | awk '{print $1}' | xargs man -Tpdf | zathura - &
fi
