#!/bin/sh

id=$(xdo id -n scratchy);
if [ -z "$id" ]; then
    $TERMINAL -n scratchy -f 'Iosevka Nerd Font:pixelsize=14:antialias=true:autohint=true' -e zsh -c "tmux new-session -A -s SCRATCHPAD" ;
else
    action='hide';
    if [[ $(xprop -id $id | awk '/window state: / {print $3}') == 'Withdrawn' ]]; then
        action='show';
    fi
    xdo $action -n scratchy
fi
