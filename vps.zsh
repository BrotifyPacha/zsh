# /usr/bin/zsh

function vps() {
    if [[ $# < 1 && $(pwd) =~ "servers\/(devel[0-9]?|embla.immo)" ]] {
        server=$(pwd | grep -oP '(devel[0-9]?|embla)')
        echo "dir: $server"
        vps $server
        return
    }
    if [[ "$1" == "-h" || $# == 0 ]] {
        echo "Usage: logs <project>"
        echo "Use tab completion"
        return
    }
    case $1 in
        "salute.3180")
            host="admin@salute.3180.mts.by.mtu.immo"
            ;;
        "embla")
            host="pgusev@embla.immo"
            ;;
        "fenrir")
            host="pgusev@fenrir.immo"
            ;;
        "devel") ;&
        "devel2") ;&
        "devel3")
            host="pgusev@nv-$1.mtu.immo"
            ;;
        *)
            host="admin@vps$1.mtu.immo"
    esac
    if [[ $(pwd) =~ "servers\/(devel[0-9]?|embla.immo)" ]] {
        server=$(pwd | grep -oP '(devel[0-9]?|embla)')
        if [[ "$1" == "$server" ]] {
            dir='~'$(pwd | grep -oP '(devel.*|embla.immo.*)' | sed 's/\(devel[0-9]\?\|embla.immo\)//')
            echo "ssh -A -t $host \"cd $dir ; bash --login\""
            ssh -A -t $host "cd $dir ; TERM=xterm ; bash --login"
            return
        }
    }
    echo "Trying to: ssh -A -t $host"
    ssh -A -t $host "TERM=xterm ; bash --login"
}

compdef _vps_comp vps

function _vps_comp() {
    local -a servers
    servers=(\
        'devel:'\
        'devel2:retorr, proxy-service, code-sender'\
        'devel3:easylang'\
        'fenrir:ps-content'\
        'embla:runiverse, salute-content-pusher'\
        '3180:provas-mtsrb'\
        '6221:retorr'\
        '6229:trainspotting'\
        '7108:runiverse-multimedia'\
        '6158:runiverse-mtsinfo-anec'\
        '8138:runiverse-mtsnews'\
        '7066:runiverse-weather'\
        '8088:easylang-cms, easylang-landings'\
        '8119:salute-content-pusher'\
        '8204:code-sender, proxy-service'\
    )
    _describe -V 'server' servers
    return
}
