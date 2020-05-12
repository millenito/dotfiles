#!/usr/bin/env bash

BACKUP="original-dotfiles"

[ ! -d ~/"${BACKUP}"/ ] && mkdir ~/"${BACKUP}"/ && mkdir ~/"${BACKUP}"/.config

#[ -d ~/scripts ] && cp -R ~/scripts/ ~/"${BACKUP}"/ && rm -rf ~/scripts/
#ln -sfv $(pwd)/scripts ~

#[ -f ~/.gitconfig ] && cp ~/.gitconfig ~/"${BACKUP}"/
#ln -sfv $(pwd)/.gitconfig ~

#[ -f ~/.Xresources ] && cp ~/.Xresources ~/"${BACKUP}"/
#ln -sfv $(pwd)/.Xresources ~
#xrdb ~/.Xresources

#[ -f ~/.xinitrc ] && cp ~/.xinitrc ~/"${BACKUP}"/
#ln -sfv $(pwd)/.xinitrc ~

#[ -f ~/.profile ] && cp ~/.profile ~/"${BACKUP}"/
#ln -sfv $(pwd)/.profile ~

#[ -f ~/.bashrc ] && cp ~/.bashrc ~/"${BACKUP}"/
#ln -sfv $(pwd)/.bashrc ~

#### Zsh ################################################################################
#echo -e "\e[1;93mConfiguring zsh"
#if [[ ! $(command -v zsh 2>&1) ]]; then
#    sudo pacman -S zsh  || exit 1
#fi
#
#if [ -z $(echo $SHELL | grep zsh) ]; then
#    echo -e "\e[1;93mSetting Zsh as default shell for user $USER"
#    sudo chsh -s $(which zsh) $USER || exit 1
#fi
#
#[ ! -d ~/.zgen ] && git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
#
#[ -f ~/.zshrc ] && cp ~/.zshrc ~/"${BACKUP}"/
#ln -sfv $(pwd)/.zshrc ~
#
#[ -f ~/.zshenv ] && cp ~/.zshenv ~/"${BACKUP}"/
#ln -sfv $(pwd)/.zshenv ~
#
#[ -f ~/.ideavimrc ] && cp ~/.ideavimrc ~/"${BACKUP}"/
#ln -sfv $(pwd)/.ideavimrc ~

#### Vim (Text Editor) ##################################################################
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

#### Nvim (Text Editor) ##################################################################
if [[ ! $(command -v /usr/bin/nvim 2>&1) ]]; then
    read -p $'\e[1;93mInstall Nvim? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        yay -S neovim python-neovim  || exit 1
    fi
fi
read -p $'\e[1;93mCopy Nvim configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [[ ! $(command -v node -v 2>&1) ]] && sudo pacman -S nodejs yarn || exit 1
    [ -d ~/.config/nvim/ ] && cp ~/.config/nvim/ ~/"${BACKUP}"/ && rm -f ~/.config/nvim/
    [ -d ~/.config/coc/ ] && cp ~/.config/coc/ ~/"${BACKUP}"/ && rm -f ~/.config/coc/
    ln -sfv $(pwd)/.config/nvim/ ~/.config/ && nvim -es -V -u ~/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"
    ln -sfv $(pwd)/.config/coc/ ~/.config/ && yarn --cwd ~/.config/coc/extensions/ install
    sudo yarn global add bash-language-server
fi

#### Polybar (Status bar) ###############################################################
if [[ ! $(command -v polybar 2>&1) ]]; then
    read -p $'\e[1;93mInstall Polybar? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S polybar jq udisks2 noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra || exit 1
        yay -S ttf-symbola nerd-fonts-ubuntu-mono  || exit 1
        command -v bluetoothctl >/dev/null 2>&1 || sudo pacman -S bluez-utils || exit 1
    fi
fi
read -p $'\e[1;93mCopy Polybar configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -d ~/.config/polybar/ ] && cp -R ~/.config/polybar/ ~/"${BACKUP}"/.config && rm -rf ~/.config/polybar/
    ln -sfv $(pwd)/.config/polybar/ ~/.config/
fi

#### Mpv (Video Player) #################################################################
if [[ ! $(command -v polybar 2>&1) ]]; then
    read -p $'\e[1;93mInstall Mpv? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S mpv || exit 1
    fi
fi
read -p $'\e[1;93mCopy Mpv configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -d ~/.config/mpv/ ] && cp -R ~/.config/mpv/ ~/"${BACKUP}"/.config && rm -rf ~/.config/mpv/
    ln -sfv $(pwd)/.config/mpv/ ~/.config/
fi

#### Transmission (Torrent client) #####################################################
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
    ln -sfv $(pwd)/.local/share/applications/torrent-scr.desktop ~/.local/share/applications/
fi

echo -e "\e[1;93mAll Done! please reboot your computer or restart Xorg"
