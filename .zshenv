export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/google-chrome-stable
# export TERM=xterm-256color
# export TERM=st
export TERMINAL=st

# set personal path variables
export P5=$HOME/vagrant-localan/PHP53/ # vagrant localan php5
export P7=$HOME/vagrant-localan/PHP70/ # vagrant localan php7
export PROJECTS=$HOME/projects/

export DOTFILES=$HOME/dotfiles/ # dotfiles repo
export NOTES=$HOME/notes # notes directory
export SCRIPTS=$HOME/scripts

# fzf commands & options
export FZF_DEFAULT_COMMAND="rg --files -g '*' --hidden --iglob '*/database.php' --iglob '!*.git*' --iglob '!*cache*' --iglob '!*cargo*'"
export FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=grid --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right' --bind='f3:execute(bat --style=numbers {} || less -f {}),ctrl-g:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
export FZF_ALT_C_COMMAND="fd --hidden --exclude '*Cache*' --exclude '*cache*' --exclude '*.cargo*' --exclude '*.git*' --follow -t d ."
export FZF_ALT_C_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# nnn file manager
export NNN_BMS='h:~;a:/hdd/Anime'   
export NNN_CONTEXT_COLORS='1234'    
export NNN_USE_EDITOR=1
export NNN_OPS_PROG=1

# clipmenu
export CM_LAUNCHER=$SCRIPTS/rofi/rofi-clipmenu.sh
export CM_DIR=/tmp/clipmenu

export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH=$PATH:~/scripts
