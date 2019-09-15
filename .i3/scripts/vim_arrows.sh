#!/usr/bin/bash

# hjkl = arrow keys
xmodmap -e "keycode 45 = Up"
xmodmap -e "keycode 44 = Down"
xmodmap -e "keycode 43 = Left"
xmodmap -e "keycode 46 = Right"

# wasd = arrow keys
xmodmap -e "keycode 25 = Up"
xmodmap -e "keycode 39 = Down"
xmodmap -e "keycode 38 = Left"
xmodmap -e "keycode 40 = Right"

xmodmap -e "keycode 13 = End"
xmodmap -e "keycode 19 = Home"
