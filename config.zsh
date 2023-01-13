#! /usr/bin/zsh

function config {
    if [[ $# == 0 ]] {
        cd ~/.config/zsh ; nvim .zshrc
    }
    case $1 in
        install)
            shift
            case "$1" in
                '') ;&
                'all')
                    config_install_packages
                    config_install_binaries
                    config_install_repos
                    config_install_snaps
                    ;;
                'packages') config_install_packages ;;
                'binaries') config_install_binaries ;;
                'repos') config_install_repos ;;
            esac
            ;;
        bspc) cd ~/.config/bspwm ; nvim bspwmrc;;
        ssh) cd ~/.ssh ; nvim config;;
    esac
}

function config_initial_setup {
    sudo systemctl start docker.service
    sudo usermod -aG docker $USER
}

function config_install_binaries {
    typeset -a urls
    urls=(
        https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
        https://github.com/Kong/insomnia/releases/download/core%402022.7.0/Insomnia.Core-2022.7.0.AppImage
    )
    mkdir ~/.local/bin || true
    for url ("$urls[@]") do
        bin_name=$(echo "$url" | grep -Po '[^/]+$' | awk --field-separator '.' '{print $1}' | tr '[:upper:]' '[:lower:]')
        bin_path="$HOME/.local/bin/$bin_name"
        wget -o $bin_path "$url" && chmod a+x $bin_path
        echo "$bin_name done"
    done
}

function config_install_packages {
    padding='  '
    green='\033[0;32m'
    red='\033[0;31m'
    reset='\033[0m'
    typeset -a packages
    packages=(
        # system
        picom
        bspwm
        wmname
        wmctrl
        xorg-xprop
        psensor
        xclip
        xdo
        # user
        firefox
        brave-browser
        telegram-desktop
        zsa-wally
        kitty
        # dev
        # bind - network utilities
        bind
        docker
        docker-compose
        go
        make
        npm
        delve
        kubectl
        ripgrep
    )
    for package ("$packages[@]") do
        echo $padding$package
        pamac install $package
        success=$?
        echo -n $padding
        if [ $success ] ; then
            echo -n $green$reset
        else
            echo -n $red$reset
        fi
        echo $padding$package
    done
    
}

function config_install_repos {
    cd ~/.config
    echo Cloning configs...
    echo Cloning kitty config
    git clone git@github.com:BrotifyPacha/kitty.git
    echo Cloning nvim config
    git clone git@github.com:BrotifyPacha/nvim.git
    echo Cloning bspwm config
    git clone git@github.com:BrotifyPacha/bspwm.git
}

function config_install_snaps {
    sudo ln -s /var/lib/snapd/snap /snap
    snap install datagrip --channel 2021.1/stable --classic
}

compdef _config_comp config
function _config_comp() {
    _values 'config'\
        'ssh[ssh]'\
        'install[install packages]'\
        'bspc[bspwm]'\
        '[zsh]'
    return
}
