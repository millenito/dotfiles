#!/usr/bin/env sh
# launch rofi on a directory and open the selected file using mpv or cd into it if it's a directory

cd $TRANS_DEFAULT_DIR # /hdd/Anime

# Loop until file is selected
while true; do
    LS=$(/bin/ls --group-directories-first -p )
    PICK=$( printf "..\\n${LS}" | rofi -dmenu -i -p "Choose video")

    if [ -d "$PICK" ] || [ "$PICK" == ".." ]; then
        cd "$PICK"
    elif [ -f "$PICK" ]; then
        mpv "$PICK" && break
    else
        break
    fi
done
