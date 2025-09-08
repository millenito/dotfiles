#!/bin/bash
# Save as ~/bin/open-with-vim.sh

filepath="$1"

osascript << EOF
tell application "iTerm2"
    if not (exists window 1) then
        create window with default profile
    end if
    tell current session of current window
        write text "[ -n \"\$TMUX\" ] && tmux new-window \"nvim '${filepath}'\" || nvim '${filepath}'"
    end tell
    activate
end tell
EOF
