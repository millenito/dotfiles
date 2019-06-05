#!/usr/bin/bash
 
# swap caps lock & escape
setxkbmap -option caps:escape
setxkbmap -option caps:swapescape

# set key repetition speed & delay jadi lebih cepet (50 repeats/200ms delay sebelum click)
xset r rate 200 50

# bind tombol menu di kanan jadi mod (WINDOWS/SUPER) kedua
xmodmap -e 'keycode 135 = Super_L' && xset -r 135 

# alt menjadi modifier key untuk hjkl = kiri,bawah,atas,kanan (ALT KIRI TIDAK BISA DIGUNAKAN LAGI,
#GUNAKAN ALT KANAN)
# xmodmap ~/.i3/scripts/.xmodmap
