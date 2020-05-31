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

#[ -f ~/.config/mimeapps.list ] && cp ~/.config/mimeapps.list ~/"${BACKUP}"/.config/
#ln -sfv $(pwd)/.config/mimeapps.list ~/.config/

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
        sudo pacman -S gvim ctags || exit 1 # Because gvim includes vim with clipboard support in arch
    fi
fi
read -p $'\e[1;93mCopy Vim configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -f ~/.vimrc ] && cp ~/.vimrc ~/"${BACKUP}"/ && rm -f ~/.vimrc
    ln -sfv $(pwd)/.vimrc ~
fi

#### Nvim (Text Editor) #################################################################
if [[ ! $(command -v /usr/bin/nvim 2>&1) ]]; then
    read -p $'\e[1;93mInstall Nvim? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        yay -S neovim python-neovim  || exit 1
    fi
fi
read -p $'\e[1;93mCopy Nvim configs? (will install nodejs, npm & yarn for coc plugin) (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [[ ! $(command -v node -v 2>&1) && ! $(command -v npm -v 2>&1) && ! $(command -v yarn -v 2>&1) ]] && echo -e "\e[1;93mInstalling nodejs npm & yarn!" && sudo pacman -S nodejs yarn npm || exit 1
    sudo pacman -S ctags || exit 1
    [ -d ~/.config/nvim/ ] && cp ~/.config/nvim/ ~/"${BACKUP}"/ && rm -f ~/.config/nvim/
    [ -d ~/.config/coc/ ] && cp ~/.config/coc/ ~/"${BACKUP}"/ && rm -f ~/.config/coc/
    ln -sfv $(pwd)/.config/nvim/ ~/.config/ && nvim -es -V -u ~/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"
    ln -sfv $(pwd)/.config/coc/ ~/.config/ && npm install --prefix ~/.config/coc/extensions/
    sudo npm i -g bash-language-server
fi

#### St (Terminal) ######################################################################
read -p $'\e[1;93mInstall personal build of St? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    yay -S nerd-fonts-iosevka
    git clone git@github.com:millenito/st.git && cd st && make && sudo make install && cd ..
fi

#### Compton (Compositor) ##############################################################
if [[ ! $(command -v compton 2>&1) ]]; then
    read -p $'\e[1;93mInstall Compton? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S picom || exit 1
    fi
fi
read -p $'\e[1;93mCopy Compton configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -f ~/.config/compton.conf ] && cp ~/.config/compton.conf ~/"${BACKUP}"/.config && rm -f ~/.config/compton.conf
    ln -sfv $(pwd)/.config/compton.conf ~/.config
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

#### Tmux (Terminal Multiplexer) ########################################################
if [[ ! $(command -v tmux 2>&1) ]]; then
    read -p $'\e[1;93mInstall Tmux? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S tmux || exit 1
    fi
fi
read -p $'\e[1;93mCopy Tmux configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -f ~/.tmux.conf ] && cp ~/.tmux.conf ~/"${BACKUP}"/ && rm -f ~/.tmux.conf
    ln -sfv $(pwd)/.tmux.conf ~
fi

#### Ranger (File Manager) ##############################################################
if [[ ! $(command -v ranger 2>&1) ]]; then
    read -p $'\e[1;93mInstall Ranger? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S ranger atool file highlight poppler python-ueberzug atool pdftoppm || exit 1
    fi
fi
read -p $'\e[1;93mCopy Ranger configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -d ~/.config/ranger/ ] && cp -R ~/.config/ranger/ ~/"${BACKUP}"/.config && rm -rf ~/.config/ranger/
    ln -sfv $(pwd)/.config/ranger/ ~/.config/
fi

#### Zathura (Document Viewer) ##########################################################
if [[ ! $(command -v zathura 2>&1) ]]; then
    read -p $'\e[1;93mInstall Zathura? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S zathura zathura-pdf-poppler zathura-cb zathura-djvu || exit 1
    fi
fi
read -p $'\e[1;93mCopy Zathura configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -d ~/.config/zathura/ ] && cp -R ~/.config/zathura/ ~/"${BACKUP}"/.config && rm -rf ~/.config/zathura/
    ln -sfv $(pwd)/.config/zathura/ ~/.config/
fi

#### Sxiv (Image Viewer) ################################################################
if [[ ! $(command -v sxiv 2>&1) ]]; then
    read -p $'\e[1;93mInstall Sxiv? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S sxiv || exit 1
    fi
fi
read -p $'\e[1;93mCopy Sxiv configs? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    [ -d ~/.config/sxiv/ ] && cp -R ~/.config/sxiv/ ~/"${BACKUP}"/.config && rm -rf ~/.config/sxiv/
    ln -sfv $(pwd)/.config/sxiv/ ~/.config/
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

#### CLI Tools ##########################################################################
#########################################################################################

#### bat #############################################################################
if [[ ! $(command -v bat 2>&1) ]]; then
    read -p $'\e[1;93mInstall bat? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S bat || exit 1
    fi
fi

#### fzf #############################################################################
if [[ ! $(command -v fzf 2>&1) ]]; then
    read -p $'\e[1;93mInstall fzf? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S fzf || exit 1
    fi
fi

#### translate-shell ####################################################################
if [[ ! $(command -v trans 2>&1) ]]; then
    read -p $'\e[1;93mInstall translate-shell? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        sudo pacman -S translate-shell rlwrap || exit 1
    fi
fi

#### howdoi #############################################################################
if [[ ! $(command -v howdoi 2>&1) ]]; then
    read -p $'\e[1;93mInstall howdoi? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        yay -S howdoi || exit 1
    fi
fi

#### tldr #############################################################################
if [[ ! $(command -v tldr 2>&1) ]]; then
    read -p $'\e[1;93mInstall tldr? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        yay -S tldr-bash-git || exit 1
        tldr --update
    fi
fi

#### LSD (LSDeluxe) ####################################################################
if [[ ! $(command -v lsd 2>&1) ]]; then
    read -p $'\e[1;93mInstall lsd? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        pacman -S lsd || exit 1
    fi
fi

echo -e "\e[1;93mPreviously existing config files are moved to $BACKUP"
echo -e "\e[1;93mAll Done! please reboot your computer or restart Xorg"
