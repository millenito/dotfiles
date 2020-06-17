#!/bin/sh
# Search all the bindings in sxhkdrc and output them to rofi
# format will be "<bindings>   <comment>"
# remember to always put comments above the bindings in sxhkdrc

if [ -f ~/.config/sxhkd/sxhkdrc ]; then
    PICK=$(cat ~/.config/sxhkd/sxhkdrc | awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' | column -t -s $'\t' | rofi -dmenu -i -no-show-icons -p "Sxhkd" -width 1250)
    KEYS=$(echo "$PICK" | awk 'BEGIN { FS="#" } {print $1}')
    COMMENTS=$(echo "$PICK" | awk 'BEGIN { FS="# " } {print $2}')
    notify-send "$KEYS" "$COMMENTS"
else
    notify-send -u critical 'sxhkdrc config not found!'
fi
