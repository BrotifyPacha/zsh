alias bspconfig='cd ~/.config/bspwm && nvim'

alias nvim='sudo nvim'
alias pacman='sudo pacman'
alias pamac='sudo pamac'

alias nivm='nvim'
alias nvmi='nvim'
alias vinm='nvim'
alias vnin='nvim'
alias vnim='nvim'

alias ll='ls -l'
alias la='ls -la'

function cd {
    builtin cd $@
    pwd > /tmp/cwd
}
