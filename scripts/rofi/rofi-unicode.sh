#!/usr/bin/env sh
# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running.

# Must have xclip installed to even show menu.

# taken and modified from luke smith's dotfiles (github.com/LukeSmithxyz/voidrice)
xclip -h >/dev/null || exit

if [ -e $SCRIPTS/fontawesome ]; then
    chosen=$(grep -v "#" -h $SCRIPTS/emoji $SCRIPTS/fontawesome | rofi -dmenu -p 'EMOJI' -i)
else
    chosen=$(grep -v "#" $SCRIPTS/emoji | rofi -dmenu -p 'EMOJI' -i)
fi

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | xclip -selection clipboard
notify-send "'$c' copied to clipboard." &

s=$(echo "$chosen" | sed "s/.*; //" | awk '{print $1}')
echo "$s" | tr -d '\n' | xclip
notify-send "'$s' copied to primary." &
