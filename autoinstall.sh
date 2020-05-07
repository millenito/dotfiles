#!/usr/bin/env bash

BACKUP="original-dotfiles"

[ ! -d ~/"${BACKUP}"/ ] && mkdir ~/"${BACKUP}"/ && mkdir ~/"${BACKUP}"/.config

#[ -d ~/scripts ] && cp -R ~/scripts/ ~/"${BACKUP}"/ && rm -rf ~/scripts/
#ln -sfv $(pwd)/scripts ~

#[ -f ~/.profile ] && cp ~/.profile ~/"${BACKUP}"/
#ln -sfv $(pwd)/.profile ~

#[ -f ~/.bashrc ] && cp ~/.bashrc ~/"${BACKUP}"/
#ln -sfv $(pwd)/.bashrc ~

## zsh
#echo -e "\e[1;93mConfiguring zsh"
#[ ! -d ~/.zgen ] && git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
#[ -f ~/.zshrc ] && cp ~/.zshrc ~/"${BACKUP}"/
#ln -sfv $(pwd)/.zshrc ~

#[ -f ~/.zshenv ] && cp ~/.zshenv ~/"${BACKUP}"/
#ln -sfv $(pwd)/.zshenv ~

# Vim (Text Editor)
if [[ ! $(command -v /usr/bin/vim 2>&1) ]]; then
    read -p $'\e[1;93mInstall Vim? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S gvim  || exit 1 # Because gvim includes vim with clipboard support in arch
    fi
fi
read -p $'\e[1;93mCopy Vim configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -f ~/.vimrc ] && cp ~/.vimrc ~/"${BACKUP}"/ && rm -f ~/.vimrc
    ln -sfv $(pwd)/.vimrc ~
fi

# Polybar (Status bar)
if [[ ! $(command -v polybar 2>&1) ]]; then
    read -p $'\e[1;93mInstall Polybar? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S polybar jq udisks2 noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra || exit 1
        yay -S ttf-symbola nerd-fonts-ubuntu-mono 
        command -v bluetoothctl >/dev/null 2>&1 || sudo pacman -S bluez-utils
    fi
fi
read -p $'\e[1;93mCopy Polybar configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -d ~/.config/polybar/ ] && cp -R ~/.config/polybar/ ~/"${BACKUP}"/.config && rm -rf ~/.config/polybar/
    ln -sfv $(pwd)/.config/polybar/ ~/.config/
fi

# Transmission (Torrent client)
if [[ ! $(command -v transmission-remote 2>&1) ]]; then
    read -p $'\e[1;93mInstall Transmission? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S transmission-cli || exit 1
        yay -S transmission-remote-cli-git || exit 1
    fi
fi
read -p $'\e[1;93mCopy Transmission configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -d ~/.config/transmission-daemon/ ] && cp -R ~/.config/transmission-daemon/ ~/"${BACKUP}"/.config && rm -rf ~/.config/transmission-daemon/
    ln -sfv $(pwd)/.config/transmission-daemon/ ~/.config/
fi

if [ -z $(echo $SHELL | grep zsh) ]; then
    echo -e "\e[1;93mSetting Zsh as default shell for user $USER"
    sudo chsh -s $(which zsh) $USER
fi
echo -e "\e[1;93mAll Done! please reboot your computer or restart Xorg"
