#! /usr/bin/zsh

function config {
    if [[ $# == 0 ]] {
        cd ~/.config/zsh ; nvim .zshrc
    }
    case $1 in
        install)
            config_install;;
        bspc) cd ~/.config/bspwm ; nvim bspwmrc;;
        ssh) cd ~/.ssh ; nvim config;;
    esac
}

function config_install {
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
        xorg-xprop
        psensor
        # user
        firefox
        brave-browser
        telegram-desktop
        zsa-wally
        kitty
        # dev
        docker
        docker-compose
        go
        delve
        kubectl
    )
    for package ("$packages[@]") do
        success=$(pamac install $package)
        echo -n $padding
        if [ $success ] ; then
            echo -n $green$reset
        else
            echo -n $red$reset
        fi
        echo $padding$package
    done
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
