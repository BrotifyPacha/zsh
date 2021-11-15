#! /usr/bin/zsh

function config {
    if [[ $# == 0 ]] {
        cd ~/.config/zsh ; nvim .zshrc
    }
    case $1 in
        update)
            config_update;;
        task) cd ~/.config/task-warrior ; nvim .taskrc;;
        bspc) cd ~/.config/bspwm ; nvim bspwmrc;;
    esac
}

function config_update {
    typeset -a dirs
    initDir=$(pwd)
    dirs=(zsh nvim bspwm task)
    for dir ("$dirs[@]") do
        echo " - $dir"
        cd ~/.config/$dir
        pullResult=$(git pull)
        if [[ $pullResult =~ ".*up to date.*" ]] {
            echo -e "\e[1A\e[K  $dir"
        } else {
            echo -e "\e[1A\e[K  $dir"
            echo $pullResult
        }
    done
    cd $initDir
    #  
}

compdef _config_comp config

function _config_comp() {
    _values 'config'\
        'task[task-warrior]'\
        'bspc[bspwm]'\
        '[zsh]'
    return
}

compdef _config_comp config

function _config_comp() {
    _values 'config'\
        'task[task-warrior]'\
        'bspc[bspwm]'\
        '[zsh]'
    return
}
