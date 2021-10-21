alias bspconfig='cd ~/.config/bspwm && nvim'

alias pacman='sudo pacman'
alias pamac='sudo pamac'

alias nivm='nvim'
alias nvmi='nvim'
alias vinm='nvim'
alias vnin='nvim'
alias vnim='nvim'

alias ll='ls -l'
alias la='ls -la'

alias rd='cd "$(cat /tmp/cwd || ~)"'

function cd {
    builtin cd $@
    pwd > /tmp/cwd
}
