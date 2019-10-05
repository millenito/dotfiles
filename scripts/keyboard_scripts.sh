#!/usr/bin/bash

# swap caps lock & escape
# setxkbmap -option caps:escape
# setxkbmap -option caps:swapescape

# swap caps lock & control
setxkbmap -option "ctrl:swapcaps"

# set key repetition speed & delay jadi lebih cepet (50 repeats/200ms delay sebelum click)
xset r rate 200 50

# bind tombol menu di kanan jadi mod (WINDOWS/SUPER) kedua
# xmodmap -e 'keycode 135 = Super_L' && xset -r 135

# scripts control jadi modifier buat hjkl = arrows, switch menu button dengan right control (no fn)
xmodmap $SCRIPTS/.xmodmap

# xcape (https://github.com/alols/xcape)
# buat caps lock (sekarang sudah di tukar sama control) menjadi escape kalo ditekan sendiri dan menjadi control kalo dengan key lain
# xcape -e 'Control_L=Escape;Alt_L=BackSpace' -t 200
xcape -e 'Control_L=Escape' -t 200
