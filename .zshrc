# load zgen
source "${HOME}/.zgen/zgen.zsh"
# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/colored-man-pages
    # zgen load zpm-zsh/colors
    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions

    # bulk load
    # zgen loadall <<EOPLUGINS
    #     zsh-users/zsh-history-substring-search
    #     /path/to/local/plugin
# EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # completions
    zgen load zsh-users/zsh-completions src
    zgen load docker/cli contrib/completion/zsh

    # theme
    # zgen oh-my-zsh themes/avit
	# zgen oh-my-zsh themes/steeef
    # zgen oh-my-zsh themes/ys
    # zgen load marszall87/nodeys-zsh-theme nodeys
    zgen load denysdovhan/spaceship-prompt spaceship
    zgen load mafredri/zsh-async
    # zgen load sindresorhus/pure
    # zgen load geometry-zsh/geometry

    # save all to init script
    zgen save
fi

ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${HOME}/.zshrc.local)

set -o ignoreeof # xfce terminal

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt share_history # share history between different instances
setopt correct_all # autocorrect commands
# auto ls after cd with exa
autoload -U add-zsh-hook
autoload -U colors && colors
add-zsh-hook -Uz chpwd (){
     # if type exa > /dev/null 2>&1; then
     #     exa --group-directories-first
         # exa
     if type lsd > /dev/null 2>&1; then
         lsd --group-dirs first
     else
         ls
     fi
}

# Enable autocompletions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
zmodload -i zsh/complist

# Save history so we get auto suggestions
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# use the vi navigation keys in menu completion
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# vi mode zsh
bindkey -v

# GNU Readline bindings
bindkey "\C-u" vi-kill-line
bindkey "\C-k" vi-kill-eol
bindkey "\C-f" vi-forward-char
bindkey "\C-b" vi-backward-char
bindkey "^[f" vi-forward-word
bindkey "^[b" vi-backward-word
bindkey '^[[Z' undo     # Shift+tab undo last action

# 10ms for key sequences
KEYTIMEOUT=1

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Spaceship prompt
SPACESHIP_GIT_LAST_COMMIT_SHOW="${SPACESHIP_GIT_LAST_COMMIT_SHOW=true}"
SPACESHIP_GIT_LAST_COMMIT_SYMBOL="${SPACESHIP_GIT_LAST_COMMIT_SYMBOL=""}"
SPACESHIP_GIT_LAST_COMMIT_PREFIX="${SPACESHIP_GIT_LAST_COMMIT_PREFIX=""}"
SPACESHIP_GIT_LAST_COMMIT_SUFFIX="${SPACESHIP_GIT_LAST_COMMIT_SUFFIX=""}"
SPACESHIP_GIT_LAST_COMMIT_COLOR="${SPACESHIP_GIT_LAST_COMMIT_COLOR="magenta"}"

spaceship_git_last_commit() {
  [[ $SPACESHIP_GIT_LAST_COMMIT_SHOW == false ]] && return

  spaceship::is_git || return

  local 'git_last_commit_status'
  # git_last_commit_status=$(git log --pretty='format:%<(25,trunc)%s 🕑 %cr' 'HEAD^..HEAD' | head -n 1)
  # git_last_commit_status=$(git log --pretty='format:🕑 %cr %s' | head -n 1)
  git_last_commit_status=$(git log --pretty='format:🕑 %cr | %<(30,trunc)%s' | head -n 1)

  [[ -z $git_last_commit_status ]] && return

  spaceship::section \
    "$SPACESHIP_GIT_LAST_COMMIT_COLOR" \
    "$SPACESHIP_GIT_LAST_COMMIT_PREFIX" \
    "$SPACESHIP_GIT_LAST_COMMIT_SYMBOL$git_last_commit_status" \
    "$SPACESHIP_GIT_LAST_COMMIT_SUFFIX"

}
SPACESHIP_PROMPT_ORDER=(
  # time          # Time stamps section
  host          # Hostname section
  user          # Username section
  dir           # Current directory section
  docker        # Docker section
  # php           # PHP section
  git           # Git section (git_branch + git_status)
  git_last_commit
  line_sep      # Line break
  battery       # Battery level and status
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  exec_time     # Execution time
  char          # Prompt character
)
 SPACESHIP_RPROMPT_ORDER=( # Spaceship right prompt
   vi_mode       # Vi-mode indicator

)
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_USER_COLOR="red"
SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=always
SPACESHIP_HOST_SHOW_FULL=true
SPACESHIP_HOST_COLOR="cyan"
SPACESHIP_USER_PREFIX="as "
SPACESHIP_DIR_COLOR="yellow"
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
SPACESHIP_BATTERY_THRESHOLD=20
# SPACESHIP_HOST_PREFIX="using " 
SPACESHIP_VI_MODE_INSERT="-- INSERT --"
SPACESHIP_VI_MODE_NORMAL="[NORMAL]"

# pure prompt
autoload -U promptinit; promptinit

# change the path color
zstyle :prompt:pure:path color yellow 

# Untuk merubah titlebar dari st terminal
# Sumber: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#s5
case $TERM in
	st*)
        DISABLE_AUTO_TITLE="true"
	precmd () {
		# menampilkan direktori aktif (kondisi default)
        print -Pn "\e]0;st: %~\a"
	}
	preexec () {
		# menampilkan program yang sedang berjalan
		print -Pn "\e]0;st:$1\a"
	}
	;;
    *)
    DISABLE_AUTO_TITLE="false" ;;
esac

# Random man page everytime a terminal opens
# man $(find /usr/share/man/man1 -type f | shuf | head -1) | head -25

# # Change cursor shape for different vi modes.
# function zle-keymap-select {
#     if [[ ${KEYMAP} == vicmd ]] ||
#         [[ $1 = 'block' ]]; then
#             echo -ne '\e[1 q'
#
#         elif [[ ${KEYMAP} == main ]] ||
#             [[ ${KEYMAP} == viins ]] ||
#             [[ ${KEYMAP} = '' ]] ||
#             [[ $1 = 'beam' ]]; then
#                     echo -ne '\e[5 q'
#     fi
# }
# zle -N zle-keymap-select
#
#     # Use beam shape cursor on startup.
#     echo -ne '\e[5 q'
#
#     # Use beam shape cursor for each new prompt.
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }

alias pacman="sudo pacman"
alias s="ssh"
alias p="ping"
alias g="git"
alias trc="transmission-remote-cli"

alias lg="ls -l | grep"
alias lag="ls -al | grep"

# enable nvidia drivers
alias nvidia="sudo primusrun glxgears"

# startx from tty
alias sx="startx"

# nmcli wifi
alias nmlist="nmcli dev wifi list"
alias nmconn="nmcli dev wifi connect"

# set path go
#export GOROOT=/home/$USER/go/
#export GOPATH=/home/$USER/gopath/
#export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# cd to environment
alias dot='cd "$DOTFILES"'
alias note='cd "$NOTES"'
alias kul='cd "$KULIAH"'
alias scr='cd "$SCRIPTS"'
alias qmk='cd "$QMK"'
alias qmk_make='make annepro2/c18 && echo " Press LSHIFT + RSHIFT + B on Anne Pro 2 keyboard to enter IAP mode before flashing"'
alias qmk_flash="sudo ./annepro2_tools --boot annepro2_c18_millenito-annepro2-qmk.bin"

# Open ssh configs in editor
vssh(){
    $EDITOR ~/.ssh/config
}

# localan php53 & php70
p5(){
    cd "${P5}/$1"
}

p7(){
    cd "${P7}/$1"
}

compdef '_files -W $P5' p5
compdef '_files -W $P7' p7

launchl(){
    case "$(pwd)" in
        *"$P5"*)
            CURDIR=$(pwd | sed "s|"${P5}"||g")
            [ ! $(docker ps | grep php53_apache) ] && docker start php53_apache
            open -a "Google Chrome" "http://localhost:8085/${CURDIR}" >/dev/null 2>&1 & ;;
            # $BROWSER "http://localhost:8085/${CURDIR}" >/dev/null 2>&1 & ;;
        *"$P7"*)
            CURDIR=$(pwd | sed "s|"${P7}"||g")
            [ ! $(docker ps | grep php73_apache) ] && docker start php73_apache
             open -a "Google Chrome" "http://localhost:8073/${CURDIR}" >/dev/null 2>&1 & ;;
            # $BROWSER "http://localhost:8073/${CURDIR}" >/dev/null 2>&1 & ;;
            # $BROWSER "http://localhost:8080/${CURDIR}" >/dev/null 2>&1 & ;;
    esac
}

# start docker development server
alias ds5='docker start php53_apache'
alias ds7='docker start php73_apache'

# use neovim if available
if type nvim > /dev/null 2>&1; then
  alias rvim='/usr/bin/vim' # real vim
  alias v='nvim'
  alias vi='nvim'
  alias vim='nvim'
else
  alias v='vim'
  alias vi='vim'
fi

alias alacritty='WINIT_HIDPI_FACTOR=1.0 alacritty' # open alacritty normal size

if type exa > /dev/null 2>&1; then
    alias ls='exa'
    alias la='exa -a'
fi

alias cls='colorls'
# alias zaread='"$DOTFILES"/.i3/scripts/zaread' # read doc/docx/ppt/odf/ppt/pptx files with zathura (https://github.com/millenito/zaread)

# tmux
if type tmux > /dev/null 2>&1; then
    alias tm='tmux'
    alias tml='tmux ls'
    tma(){ if [[ $# -eq 0 ]]; then tmux attach; else tmux attach -t "$1"; fi } # Attach to last tmux session or attach to named session
    tmn(){ if [[ $# -eq 0 ]]; then tmux new-session; else tmux new-session -s "$1"; fi} # Create new unnamed session or use gived name
    tmk(){ if [[ $# -eq 0 ]]; then tmux kill-server; else tmux kill-session -t "$1"; fi } # Kill all session or kill named session
fi

# fuzzy_cd_anywhere (cd kemanapun dengan fzf dengan parameter (ex: fcda anime))
function fcda() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file |  sed -e 's/[[:space:]]/\\ /g'
     else
        cd -- ${file:h}
     fi
  fi
}

# fuzzy_vim (Buka fzf dan otomatis buka file yg dipilih oleh fzf dengan vim)
fv() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-/usr/bin/vim} "${files[@]}"
}

# fuzzy_cd (buke fzf dan cd ke directory yang dipilih)
fcd() {
	alias fzf_alt_c_command=$FZF_ALT_C_COMMAND
	alias fzf_alt_c_opts=fzf $FZF_ALT_C_OPTS
  local dir
  dir="$( fzf_alt_c_command $@ | fzf_alt_c_opts)" || return
  cd "$dir" || return
}

# git log with fzf and preview
fgl() {
    local commits=$(
    git log --graph --format="%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)" --color=always "$@" |
        fzf --ansi --no-sort --height 100% \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'"
      )
    if [[ -n $commits ]]; then
        local hashes=$(printf "$commits" | cut -d' ' -f2 | tr '\n' ' ')
        git show $hashes
    fi
}

# Fuzzy script (cari script dengan fzf dan buka dengan editor)
fs() { du -aL $SCRIPTS "${PROJECTS}/learning/shell-script" | awk '{print $2}' | fzf | xargs -r $EDITOR ; }

# Fuzzy projects (cd ke folder projects2 dan buka session tmux baru bernama localhost)
fp() 
{     
    if type fd > /dev/null 2>&1; then
        cd $(fd --type d --follow --exclude '*.git*' . $PROJECTS | fzf)
    else
        cd $(find -L $PROJECTS -type d | fzf)
    fi
    [ -n $(type tmux > /dev/null 2>&1) ] && [ -z "$TMUX" ] && tmn projects
}

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
    NEWDIR=$(echo "$1" | sed 's/\.[^.]*$//')
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1 -c $1  ;;
      *.tar.gz)    tar xzvf $1 -c $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xvf $1 -c $1    ;;
      *.tbz2)      tar xjf $1 -c $1  ;;
      *.tgz)       tar xvzf $1 -c $1  ;;
      *.zip)       mkdir "$NEWDIR" && unzip $1 -d "$NEWDIR"     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

alias gr='cd $(git rev-parse --show-toplevel)' # cd to git repo's root directory

# Commit & push
compush()
{
	git commit -m "$*"
	git push
}

# Commit & Push every changes
compushall()
{
	echo "Staging every changes.."
	git add .

	echo "Preparing commit.."
	git commit -a -m "$*"

	echo "Pushing to remote.."
	git push
}
alias fhi='__fzf_history__' # list history dengan fzf (key: Ctrl+r)
alias vf=fv # Alias kalau salah

# disable Ctrl+s freeze terminal
stty -ixon

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
