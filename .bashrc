#      __    _          _             __               __
#     / | / (_) /_____ ( )_____      / /_  ____ ______/ /_  __________
#    /  |/ / / __/ __ \|// ___/     / __ \/ __ `/ ___/ __ \/ ___/ ___/
#   / /|  / / /_/ /_/ / (__  )   _ / /_/ / /_/ (__  ) / / / /  / /__  
#  /_/ |_/_/\__/\____/ /____/   (_)_.___/\__,_/____/_/ /_/_/   \___/ 
#  

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		#PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
        PS1='\[\033[01;32m\]\W >>\[$(tput sgr0)\] '
	else
		#PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
        PS1='\[\033[01;32m\]\W \[$(tput sgr0)\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias la="ls -a"                          # ls all hidden files

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1   ;;
      *.tar.gz)    tar xzvf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xvf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xvzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# biar kalo masuk ssh bisa di clear
export TERM=xterm-256color

alias pacman="sudo pacman"

# enable nvidia drivers
alias nvidia="sudo primusrun glxgears"

# set path go
#export GOROOT=/home/$USER/go/
#export GOPATH=/home/$USER/gopath/
#export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# path repo dotfiles
export dotfiles=$HOME/dotfiles/
alias dotfiles='cd "$dotfiles"'

# localan php53 & php70
export p5=/home/$USER/vagrant-localan/PHP53/
export p7=/home/$USER/vagrant-localan/PHP70/
alias p5='cd "$p5"'
alias p7='cd "$p7"'
alias p5up='cd "$p5" && vagrant up'
alias p7up='cd "$p7" && vagrant up'
alias p5halt='cd "$p5" && vagrant halt'
alias p7halt='cd "$p7" && vagrant halt'

# vim mode (pencet ESC untuk masuk normal mode vim)
set -o vi

# vim
alias v='vim'
alias vi='vim'

alias alacritty='WINIT_HIDPI_FACTOR=1.0 alacritty'

# export FZF_DEFAULT_COMMAND='rg --hidden --ignore .git -g ""'

# Buka fzf dan otomatis buka file yg dipilih oleh fzf dengan vim
fv() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# cd folder yang dipiling dengan fzf
function fcd() {
      local dir
        dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
    }

# cd kemanapun dengan fzf dengan parameter (ex: fcda anime)
function fcda() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

function codevim() {
       printf '\e]710;%s\007' "xft:Hack Nerd Font Mono:style=Regular:size=10"
       /usr/bin/vim "$@"
       printf '\e]710;%s\007' "xft:SHack Nerd auceCodePro Nerd Font Mono:style=Regular:size=11"
 }

# disable Ctrl+s freeze terminal
stty -ixon
