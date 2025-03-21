export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export EDITOR=nvim
export VISUAL=$(which nvim)
export READER=/usr/bin/zathura
export BROWSER=/usr/bin/google-chrome-stable
export TERMINAL=st
# Uncomment if not using tmux
# [ -z "${TMUX}" ] && export TERM=xterm-256color

# set personal path variables
export PROJECTS="$HOME/projects"
export P5="$PROJECTS/localhost/PHP53/" # localan php5
export P7="$PROJECTS/localhost/PHP73/" # localan php7
export P8="$PROJECTS/localhost/PHP81/" # localan php8
export NJS="$PROJECTS/localhost/nodejs/" # localan nodejs

export DOTFILES="$HOME/dotfiles/" # dotfiles repo
export NOTES="$HOME/notes" # notes directory
export SCRIPTS="$HOME/scripts"
export KULIAH="$HOME/Documents/Kuliah/Semester 8"
export QMK="$HOME/Downloads/annepro2_qmk/annepro-qmk" # annepro2 keyboard qmk build dir

# fzf commands & options
if type rg > /dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="rg --files --follow -g '*' --hidden --iglob '*/database.php' --iglob '!*.git*' --iglob '!*cache*'"
fi

# use fdfind instead of fd if on ubuntu/debian
if type apt >/dev/null 2>&1; then
    if type fdfind > /dev/null 2>&1; then
        export FZF_ALT_C_COMMAND="fdfind --color=always --hidden --exclude '*Cache*' --exclude '*cache*' --exclude '*.git*' --follow -t d ."
    fi
else
    if type fd > /dev/null 2>&1; then
        export FZF_ALT_C_COMMAND="fd --color=always --hidden --exclude '*Cache*' --exclude '*cache*' --exclude '*.git*' --follow -t d ."
    fi
fi
export FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --multi --inline-info --preview '(highlight -O ansi -l {} 2> /dev/null || (bat --style=grid --color=always {} || cat {}) || tree -C {}) 2> /dev/null | head -200' --preview-window='right' --bind='f3:execute(bat --style=numbers --color=always {} || less -f {}),ctrl-g:toggle-preview,ctrl-v:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
export FZF_ALT_C_OPTS="--ansi --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# nnn file manager
export NNN_BMS='h:~;a:/hdd/Anime'   
export NNN_CONTEXT_COLORS='1234'    
export NNN_USE_EDITOR=1
export NNN_OPS_PROG=1
export NNN_FIFO=/tmp/nnn.fifo

# transmission
export TRANS_DEFAULT_DIR="/hdd/Anime"

# clipmenu
export CM_LAUNCHER="$SCRIPTS/rofi/rofi-clipmenu.sh"
export CM_DIR="/tmp/clipmenu"

export ANDROID_PATH="$HOME/Android/Sdk"

export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/Android/Sdk/tools/bin:$PATH"
export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
export PATH="$HOME/Android/Sdk/emulator:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$PATH:/usr/local/gcc_arm/gcc-arm-none-eabi-10.3-2021.10/bin/"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:$SCRIPTS
[ -z ${WSLENV+x} ] || export PATH="${PATH:+"$PATH:"}$SCRIPTS/xclip-xsel-WSL"
# . "$HOME/.cargo/env"
