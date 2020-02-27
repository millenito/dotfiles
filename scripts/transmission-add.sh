#!/usr/bin/env sh

# Mimeapp script for adding torrent to transmission-daemon, but will also start the daemon first if not running.
# Choose download directory using vim/neovim, creates directory if specified directory doesn't exists

tmp_file="/tmp/transmission-download-dir"
recent_dir_file="/tmp/transmission-recent-dir"
DOWNLOAD_DIR=$TRANS_DEFAULT_DIR
RECENT_DIR=$([ -f "$recent_dir_file" ] && cat "$recent_dir_file")

if [ -z "$RECENT_DIR" ]; then
    choose=$(printf "${DOWNLOAD_DIR} (Default)"\\n"Other directory" | rofi -dmenu -i -p "Choose torrent download directory")
else
    choose=$(printf "${RECENT_DIR} (Recent)"\\n"${DOWNLOAD_DIR} (Default)"\\n"Other directory" | rofi -dmenu -i -p "Choose torrent download directory" )
fi

tmp_msg=$(cat <<EOF
$DOWNLOAD_DIR
# Put down the directory you want to save your file in above this line
# C-s or Shift+ZZ to finish
# Delete first line to cancel
EOF
)

# Check transmission-daemon is running or not
pgrep -x transmission-da || (transmission-daemon && notify-send "Starting transmission daemon...")

case $choose in
    "Other directory")
        rm $tmp_file

        # Open vim with default download directory already in buffer and set maps for saving to temporary file
        echo "$tmp_msg" | "${EDITOR:-/usr/bin/vim}" -c "imap <buffer> <C-s> <esc>:wq $tmp_file <cr>" -c "map <buffer> <C-s> <esc>:wq $tmp_file <cr>" -c "noremap <buffer> ZZ :wq $tmp_file <cr>" -
        DOWNLOAD_DIR=$(sed -n 1p $tmp_file) # Get the chosen directory (first line of file) using sed

        # Check if first line starts with "#" to determine if user canceled
        if [ -z $(echo "$DOWNLOAD_DIR" | grep -Eq "^#*") ]; then
            # Creates directory if doesn't exists
            [ -d "$DOWNLOAD_DIR" ] || (mkdir -p "$DOWNLOAD_DIR"; notify-send "Directory not exist" "Creating directory $DOWNLOAD_DIR")

            # Create recent file and put directory to recent
            [ -f "$recent_dir_file" ] || touch "$recent_dir_file"
            echo "$DOWNLOAD_DIR" > "$recent_dir_file"

            transmission-remote -a "$@" --download-dir "$DOWNLOAD_DIR" && notify-send "🔽 Torrent added" "To $DOWNLOAD_DIR"
        else
            rm $tmp_file
            exit 1
        fi
        ;;
    "")
        # Exiting out of rofi (not choosing anything)
        exit 1
        ;;
    *)
        # Choosing default or recent dir
        choose=$(echo "$choose" | sed -e "s/(Default)$//g" -e "s/(Recent)$//g" -e "s/[ \t]*$//")
        transmission-remote -a "$@" --download-dir "$choose" && notify-send "🔽 Torrent added" "To $choose"
        ;;
esac

