alias bspconfig='cd ~/.config/bspwm && nvim'

alias pacman='sudo pacman'
alias pamac='sudo pamac'

alias vim='nvim -u NONE'
alias nivm='nvim'
alias nvmi='nvim'
alias vinm='nvim'
alias vnin='nvim'
alias vnim='nvim'
alias vmni='nvim'

alias ls='ls -l'
alias la='ls -la'

alias rd='cd "$(cat /tmp/cwd || ~)"'

alias xphp='XDEBUG_SESSION=1 php'

alias tsk='task'

alias k9s='k9s --splashless --logoless'

function cd {
    builtin cd $@
    pwd > /tmp/cwd
}

function mkcd {
    mkdir $@
    cd $@
}

# Git aliases
alias gg='git status'

# Docker compose aliases
alias dc='docker compose'

# Kubectl aliases
alias kcu='kubectl config use-context'
alias kn='kubens'
