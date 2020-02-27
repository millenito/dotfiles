#!/usr/bin/env sh
# Launch rofi to pick which player to play using playerctl if there is more than 1 player available (ex: spotify and chrome currently being paused, then pick which player to play)

if ! $(type playerctl >/dev/null 2>&1) ; then notify-send "Playerctl not installed, please install it first!"; exit 1; fi

PLAYERS=$(playerctl --list-all)

# Remove players that has no metadata (not playing or pausing anything)
case "$PLAYERS" in
    *chrome* )
        CHROME="$(echo "$PLAYERS" | grep chrome)"
        METADATA=$(playerctl --player=${CHROME} metadata)
        [ -z "$METADATA" ] && PLAYERS=$(echo "$PLAYERS" | sed "s/${CHROME}//g" | tr -d '[:space:]')
        ;;
esac

# Choose multiple players with rofi to play/pause, or immediately play/pause if there is only 1 player
if [ $(echo "$PLAYERS" | wc -l) -gt 1 ]; then
    PICK=$(echo "$PLAYERS" | rofi -dmenu -i -p "Choose which player to play/pause")

    [ -n "$PICK" ] && playerctl --player=${PICK} play-pause
else
    playerctl play-pause
fi
