#!/bin/sh

# Search all the bindings in sxhkdrc and output them to rofi
# format will be "<bindings>   <comment>"
# remember to always put comments above the bindings in sxhkdrc
sxhkd(){
    if [ -f ~/.config/sxhkd/sxhkdrc ]; then
        PICK=$(cat ~/.config/sxhkd/sxhkdrc | awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' | column -t -s $'\t' | rofi -dmenu -i -no-show-icons -p "Sxhkd" -width 1250)
        KEYS=$(echo "$PICK" | awk 'BEGIN { FS="#" } {print $1}')
        COMMENTS=$(echo "$PICK" | awk 'BEGIN { FS="# " } {print $2}')
        notify-send "$KEYS" "$COMMENTS"
    else
        notify-send -u critical 'sxhkdrc config not found!'
    fi
}

cliLauncher(){
body=$(cat <<EOF
r = ranger (File Manager)
t = tremc (Torrent Client)
h = htop (top alternative)
g = gtop
b = btop
EOF
)
    notify-send "Super + c (CLI Apps Launcher)" "$body"
}

guiLauncher(){
body=$(cat <<EOF
b = Chrome (Browser)
t = Thunar (File Manager)
s = Spotify (Music Player)
d = Dbeaver (DB Client)
f = FileZilla (FTP Client)
a = Pavucontrol (Audio Mixer)
p = Pamac (GUI Package Manager)
EOF
)
    notify-send "Super + g (GUI Apps Launcher)" "$body"
}

rofiLauncher(){
body=$(cat <<EOF
r = finder (File Searcher)
e = unicode (Emoji Picker)
v = mpv-picker (Mpv video picker from /hdd/anime)
m = man-viewer (Manpage Viewer in pdf format)
k = bindings (Keybindings Cheatsheet)
M = mount (Device Mounter)
p = umount (Device Unmounter)
b = bwmenu (Bitwarden Password Manager)
c = clipmenu (Clipboard Manager)
EOF
)
    notify-send "Super + d (Rofi Launchers)" "$body"
}

case $1 in
    sxhkd ) sxhkd ;;
    cli ) cliLauncher ;;
    gui ) guiLauncher ;;
    rofi ) rofiLauncher ;;
    * ) sxhkd ;;
esac
