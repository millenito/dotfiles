export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/google-chrome-stable
export TERMINAL=st
# Uncomment if not using tmux
# [ -z "${TMUX}" ] && export TERM=xterm-256color

# set personal path variables
export PROJECTS="$HOME/projects"
export P5="$PROJECTS/localhost/PHP53/" # vagrant localan php5
export P7="$PROJECTS/localhost/PHP70/" # vagrant localan php7

export DOTFILES="$HOME/dotfiles-copy/" # dotfiles repo
export NOTES="$HOME/notes" # notes directory
export SCRIPTS="$HOME/scripts"
export KULIAH="$HOME/Documents/Kuliah/Semester 4"

# fzf commands & options
if type rg > /dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="rg --files --follow -g '*' --hidden --iglob '*/database.php' --iglob '!*.git*' --iglob '!*cache*' --iglob '!*cargo*'"
fi
if type fd > /dev/null 2>&1; then
    export FZF_ALT_C_COMMAND="fd --color=always --hidden --exclude '*Cache*' --exclude '*cache*' --exclude '*.cargo*' --exclude '*.git*' --follow -t d ."
fi
export FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --multi --inline-info --preview '(highlight -O ansi -l {} 2> /dev/null || (bat --style=grid --color=always {} || cat {}) || tree -C {}) 2> /dev/null | head -200' --preview-window='right' --bind='f3:execute(bat --style=numbers --color=always {} || less -f {}),ctrl-g:toggle-preview,ctrl-v:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
export FZF_ALT_C_OPTS="--ansi --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# nnn file manager
export NNN_BMS='h:~;a:/hdd/Anime'   
export NNN_CONTEXT_COLORS='1234'    
export NNN_USE_EDITOR=1
export NNN_OPS_PROG=1

# transmission
export TRANS_DEFAULT_DIR="/hdd/Anime"

# clipmenu
export CM_LAUNCHER="$SCRIPTS/rofi/rofi-clipmenu.sh"
export CM_DIR="/tmp/clipmenu"

export ANDROID_PATH="$HOME/Android/Sdk"

export PATH="$HOME/Android/Sdk/tools/bin:$PATH"
export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
export PATH="$HOME/Android/Sdk/emulator:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH=$PATH:$SCRIPTS
