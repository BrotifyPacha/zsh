# /usr/bin/zsh

function explore() {
    if [[ $1 == '-c' || $1 =~ '--clear' ]] {
        shift
        kill -9 $(ps -C sshfs -o pid=) 2>/dev/null
        for mountPath in $HOME/workspace/{devel{,2,3},embla.immo}; do
            fusermount -uz $mountPath 2>/dev/null
        done
    }
    if [[ $# < 1 || $# > 1 ]] {
        echo 'Usage: explore <devel[2|3]|embla>'
    } else {
        case $1 in
            embla)
                local host="pgusev@embla.immo:/home/pgusev/"
                local folder="$HOME/workspace/embla.immo/"
                ;;
            *)
                local host="pgusev@nv-$1.mtu.immo:/home/pgusev/"
                local folder="$HOME/workspace/$1"
                ;;
        esac
        sshfs $host $folder > /dev/null 2>&1
        cd $folder
    }
}

compdef _explore_comp explore

function _explore_comp() {
    _values 'server' 'devel' 'devel2' 'devel3' 'embla'
    return
}
