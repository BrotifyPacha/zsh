#! /usr/bin/zsh

pkg_list=(
    brave-browser
    shotwell
    evolution
    bspwm
    sxhkd
    picom
    kitty
    neovim
    blueberry
    python3
    nodejs
    sshfs
    jq
    wmctrl
)

function config {
    if [[ $# == 0 ]] {
        nvim ~/.config/zsh/.zshrc
    }
    case $1 in
        update)
            config_update;;
        test)
            config_test;;
    esac
}

function config_update {
    echo 'Updating config...'
    echo 'Updating zsh...'
    cd ~/.config/zsh && git pull 2>/dev/null
    echo 'Updating nvim...'
    cd ~/.config/nvim && git pull 2>/dev/null
    echo 'Updating bspwm...'
    cd ~/.config/bspwm && git pull 2>/dev/null

}

function config_test {
    for pkg in $pkg_list; do
        is_installed=$(pacman -Qs $pkg)
        if [[ $is_installed ]] {
            echo "  $pkg"
        } else {
            echo "  $pkg"
        }
    done
}
