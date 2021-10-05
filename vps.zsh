# /usr/bin/zsh

function vps() {
    if [[ $# < 1 && $(pwd) == *"devel"* ]] {
        devel=$(pwd | grep -o 'devel[0-9]\?')
        echo "dir devel $devel"
        vps $devel
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
        "devel") ;&
        "devel2") ;&
        "devel3")
            host="pgusev@nv-$1.mtu.immo"
            ;;
        *)
            host="admin@vps$1.mtu.immo"
    esac
    if [[ $(pwd) == *"devel"* ]] {
        devel=$(pwd | grep -o 'devel[0-9]\?')
        if [[ "$1" == "$devel" ]] {
            dir=$(pwd | grep -o 'devel.*')
            dir='~/'${dir:7}
            echo "ssh -A -t $host \"cd $dir ; bash --login\""
            ssh -A -t $host "cd $dir ; bash --login"
            return
        }
    }
    echo "Trying to: ssh -A -t $host"
    ssh -A -t $host
}

compdef _vps_comp vps

function _vps_comp() {
    local -a servers
    servers=(\
        '6221:retorr'\
        '6229:trainspotting'\
        '8088:easylang-cms, easylang-landings'\
        '8204:code-sender, proxy-service'\
    )
    _describe 'server' servers
    return
}
