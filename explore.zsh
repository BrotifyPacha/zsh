# /usr/bin/zsh

servers="$HOME/workspace/servers"

function explore() {
    if [[ $# < 1 || $# > 1 ]] {
        echo 'Usage: explore <devel[2|3]|embla>'
        return
    }
    if [[ $1 == '-c' || $1 =~ '--clear' ]] {
        shift
        kill -9 $(ps -C sshfs -o pid=) 2>/dev/null
        for mountPath in $servers/* ; do
            fusermount -uz $mountPath 2>/dev/null
        done
        echo 'Connections closed'
        return
    }
    case $1 in
        embla)
            local host="pgusev@embla.immo:/home/pgusev/"
            local folder="embla.immo"
            ;;
        fenrir)
            local host="pgusev@fenrir.immo:/home/pgusev/"
            local folder="fenrir.immo"
            ;;
        *)
            local host="pgusev@nv-$1.mtu.immo:/home/pgusev/"
            local folder="$1"
            ;;
    esac
    dir="$servers/$folder"
    mkdir -p "$dir"
    sshfs $host "$dir" > /dev/null 2>&1
    cd "$dir"
}

compdef _explore_comp explore

function _explore_comp() {
    _arguments \
        '-c[clear existing connections]:clearArg'
    _values 'server'\
        'embla[php-5.2 - runiverse/configs, content-pusher]'\
        'fenrir[php-5.3 - ps-content]'\
        'devel[php-5.6 - provas-core, provas-callcenter]'\
        'devel2[php-7.1 - code-sender, proxy-service, simple-subscr, retorr]'\
        'devel3[php-7.4 - easylang-cms, landings]'
    return
}
