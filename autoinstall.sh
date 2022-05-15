#!/usr/bin/env bash

# If using ubuntu or debian
if type apt >/dev/null 2>&1; then
	DISTRO="debian"
	installpkg(){ sudo apt-get -y install "$1"; }
    installpkg2(){ sudo apt-get -y install "$1"; }
elif type brew >/dev/null 2>&1; then
# If using macosx
	DISTRO="macos"
	installpkg(){ brew install "$1"; }
    installpkg2(){ brew install --cask "$1"; }
else
# else using arch or manjaro
	DISTRO="arch"
	installpkg(){ sudo pacman -S "$1"; }
    installpkg2(){ sudo pacman -S "$1"; }
fi

BACKUP="original-dotfiles"

[ ! -d ~/"${BACKUP}"/ ] && mkdir ~/"${BACKUP}"/ && mkdir ~/"${BACKUP}"/.config

[ -d ~/scripts ] && cp -R ~/scripts/ ~/"${BACKUP}"/ && rm -rf ~/scripts/
ln -sfv $(pwd)/scripts ~

[ -f ~/.gitconfig ] && cp ~/.gitconfig ~/"${BACKUP}"/
ln -sfv $(pwd)/.gitconfig ~

[ -f ~/.Xresources ] && cp ~/.Xresources ~/"${BACKUP}"/
ln -sfv $(pwd)/.Xresources ~
xrdb ~/.Xresources

[ -f ~/.xinitrc ] && cp ~/.xinitrc ~/"${BACKUP}"/
ln -sfv $(pwd)/.xinitrc ~

[ -f ~/.profile ] && cp ~/.profile ~/"${BACKUP}"/
ln -sfv $(pwd)/.profile ~

[ -f ~/.bashrc ] && cp ~/.bashrc ~/"${BACKUP}"/
ln -sfv $(pwd)/.bashrc ~

[ -f ~/.config/mimeapps.list ] && cp ~/.config/mimeapps.list ~/"${BACKUP}"/.config/
ln -sfv $(pwd)/.config/mimeapps.list ~/.config/

### Zsh ################################################################################
echo -e "\e[1;93mConfiguring zsh"
if [[ ! $(command -v zsh 2>&1) ]]; then
    installpkg zsh  || exit 1
fi

if [ -z $(echo $SHELL | grep zsh) ]; then
    echo -e "\e[1;93mSetting Zsh as default shell for user $USER"
    sudo chsh -s $(which zsh) $USER || exit 1
fi

[ ! -d ~/.zgen ] && git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

[ -f ~/.zshrc ] && cp ~/.zshrc ~/"${BACKUP}"/
ln -sfv $(pwd)/.zshrc ~

[ -f ~/.zshenv ] && cp ~/.zshenv ~/"${BACKUP}"/
ln -sfv $(pwd)/.zshenv ~

[ -f ~/.ideavimrc ] && cp ~/.ideavimrc ~/"${BACKUP}"/
ln -sfv $(pwd)/.ideavimrc ~

#### Bspwm & sxhkd ######################################################################
if [[ $(command -v bspwm 2>&1) ]]; then
    read -p $'\e[1;93mCopy bspwm & sxhkd configs? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        [ -d ~/.config/bspwm/ ] && cp -R ~/.config/bspwm/ ~/"${BACKUP}"/.config && rm -rf ~/.config/bspwm/
        ln -sfv $(pwd)/.config/bspwm/ ~/.config/
        [ -d ~/.config/sxhkd/ ] && cp -R ~/.config/sxhkd/ ~/"${BACKUP}"/.config && rm -rf ~/.config/sxhkd/
        ln -sfv $(pwd)/.config/sxhkd/ ~/.config/
    fi
fi

#### Vim (Text Editor) ##################################################################
if [[ ! $(command -v /usr/bin/vim 2>&1) ]]; then
    read -p $'\e[1;93mInstall Vim? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        if [[ $DISTRO = 'debian' ]]; then
            installpkg vim vim-gtk3g universal-ctags || exit 1
        else
            installpkg vim gvim ctags || exit 1 # Because gvim includes vim with clipboard support in arch
        fi
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
        [[ ! $(command -v xsel -v 2>&1) || ! $(command -v wl-clipboard -v 2>&1) ]] && echo -e "\e[1;93mInstalling xsel!" && installpkg xsel || exit 1
        if [[ $DISTRO = 'debian' ]]; then
            installpkg ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip || exit 1
            git clone git@github.com:neovim/neovim.git && cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=Release -j4 && sudo make install || exit 1
            installpkg python3-neovim || exit 1
        elif [[ $DISTRO = 'macos' ]]; then
            installpkg neovim
        else
            yay -S neovim python-neovim  || exit 1
        fi
    fi
fi
read -p $'\e[1;93mCopy Nvim configs? (will install nodejs, npm & yarn for coc plugin) (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    if [[ ! $(command -v node -v 2>&1) && ! $(command -v npm -v 2>&1) && ! $(command -v yarn -v 2>&1) ]]; then
        if [[ $DISTRO = 'debian' ]]; then
            echo -e "\e[1;93mInstalling nodejs npm & yarn!" && curl -fsSL https://deb.nodesource.com/setup_14.x | sudo bash - && installpkg nodejs npm && sudo npm install -g yarn || exit 1
        elif [[ $DISTRO = 'macos' ]]; then
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && source ~/.zshrc && nvm install 16 && nvm use 16
        fi
    fi
    installpkg ctags || installpkg universal-ctags || exit 1
    [ -d ~/.config/nvim/ ] && cp -R ~/.config/nvim/ ~/"${BACKUP}"/ && rm -rf ~/.config/nvim/
    [ -d ~/.config/coc/ ] && cp -R ~/.config/coc/ ~/"${BACKUP}"/ && rm -rf ~/.config/coc/
    ln -sfv $(pwd)/.config/nvim/ ~/.config/ && nvim -es -V -u ~/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa"
    ln -sfv $(pwd)/.config/coc/ ~/.config/ && npm install --prefix ~/.config/coc/extensions/
    sudo npm i -g bash-language-server
fi

#### St (Terminal) ######################################################################
read -p $'\e[1;93mInstall personal build of St? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    if [[ $DISTRO = 'debian' ]]; then
            wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip && mkdir Iosevka && unzip Iosevka.zip -d Iosevka && sudo mv Iosevka /usr/local/share/fonts && rm -rf Iosevka.zip Iosevka
    elif [[ $DISTRO = 'macos' ]]; then
        brew tap homebrew/cask-fonts &&  installpkg2 font-iosevka-nerd-font
        else
            yay -S nerd-fonts-iosevka
    fi
    git clone git@github.com:millenito/st.git && cd st && make && sudo make install && cd ..
    sudo fc-cache -f -v
fi

#### Rofi (Dmenu Replacement) ###########################################################
read -p $'\e[1;93mInstall Rofi? (Y/N)\e[0m: ' confirm
if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
    installpkg rofi
    [ -d ~/.config/rofi/ ] && cp -R ~/.config/rofi/ ~/"${BACKUP}"/.config && rm -rf ~/.config/rofi/
fi

#### Compton (Compositor) ##############################################################
if [[ ! $(command -v compton 2>&1) ]]; then
    read -p $'\e[1;93mInstall Compton? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        installpkg picom || exit 1
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
        installpkg polybar jq udisks2 noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra || exit 1
        yay -S ttf-symbola nerd-fonts-ubuntu-mono  || exit 1
        command -v bluetoothctl >/dev/null 2>&1 || installpkg bluez-utils || exit 1
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
        installpkg mpv || exit 1
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
        installpkg tmux || exit 1
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
        installpkg ranger atool file highlight poppler python-ueberzug atool pdftoppm || exit 1
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
        installpkg zathura zathura-pdf-poppler zathura-cb zathura-djvu || exit 1
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
        installpkg sxiv || exit 1
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
        installpkg transmission-cli || exit 1
        yay -S tremc-git || exit 1
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

#### ripgrep ############################################################################
if [[ ! $(command -v rg 2>&1) ]]; then
    read -p $'\e[1;93mInstall rg? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        installpkg ripgrep || exit 1
    fi
fi

#### fd ################################################################################
if [[ $DISTRO = 'debian' ]]; then
    if [[ ! $(command -v fdfind 2>&1) ]]; then
        read -p $'\e[1;93mInstall fd? (Y/N)\e[0m: ' confirm
        if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
            installpkg fd-find || exit 1
            ln -s $(which fdfind) ~/.local/bin/fd
        fi
    fi
else
    if [[ ! $(command -v fd 2>&1) ]]; then
        read -p $'\e[1;93mInstall fd? (Y/N)\e[0m: ' confirm
        if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
            installpkg fd || exit 1
        fi
    fi
fi

#### bat ###############################################################################
if [[ ! $(command -v bat 2>&1) ]]; then
    read -p $'\e[1;93mInstall bat? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        if [[ $DISTRO = 'debian' ]]; then
            wget https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_amd64.deb && sudo dpkg -i bat_0.18.0_amd64.deb && rm bat_0.18.0_amd64.deb || exit 1
        else
            installpkg bat || exit 1
        fi
    fi
fi

#### fzf ###############################################################################
if [[ ! $(command -v fzf 2>&1) ]]; then
    read -p $'\e[1;93mInstall fzf? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        installpkg fzf || exit 1
    fi
fi

#### translate-shell ####################################################################
if [[ ! $(command -v trans 2>&1) ]]; then
    read -p $'\e[1;93mInstall translate-shell? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        installpkg translate-shell rlwrap || exit 1
    fi
fi

#### howdoi #############################################################################
if [[ ! $(command -v howdoi 2>&1) ]]; then
    read -p $'\e[1;93mInstall howdoi? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        if [[ $DISTRO = 'debian' ]]; then
            installpkg python3-pip && pip install howdoi || exit 1
        else
            yay -S howdoi || exit 1
        fi
    fi
fi

#### tldr #############################################################################
if [[ ! $(command -v tldr 2>&1) ]]; then
    read -p $'\e[1;93mInstall tldr? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        if [[ $DISTRO = 'debian' ]]; then
            installpkg tldr || exit 1
        else
            yay -S tldr-bash-git || exit 1
        fi
        tldr --update
    fi
fi

#### LSD (LSDeluxe) ####################################################################
if [[ ! $(command -v lsd 2>&1) ]]; then
    read -p $'\e[1;93mInstall lsd? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        if [[ $DISTRO = 'debian' ]]; then
            wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb && sudo dpkg -i lsd_0.20.1_amd64.deb && rm lsd_0.20.1_amd64.deb || exit 1
        else
            installpkg lsd || exit 1
        fi
    fi
fi

#### Clippmenu #########################################################################
if [[ ! $(command -v clipmenu 2>&1) ]]; then
    read -p $'\e[1;93mInstall clipmenu? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        installpkg clipmenu || exit 1
    fi
fi

#### bitwarden-rofi #########################################################################
if [[ ! $(command -v bwmenu 2>&1) ]]; then
    read -p $'\e[1;93mInstall bitwarden-rofi? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        yay -S bitwarden-rofi-git || exit 1
        echo -e "\e[1;32mRemember to unlock login using bitwarden-cli (bw login <email> <password>)"
    fi
fi

#### flameshot #########################################################################
if [[ ! $(command -v flameshot 2>&1) ]]; then
    read -p $'\e[1;93mInstall flameshot? (Y/N)\e[0m: ' confirm
    if [[ $confirm = 'Y' || $confirm = 'y' || $confirm = "" ]]; then
        installpkg2 flameshot || exit 1
    fi
fi

echo -e "\e[1;93mPreviously existing config files are moved to $BACKUP"
echo -e "\e[1;93mAll Done! please reboot your computer or restart Xorg"
