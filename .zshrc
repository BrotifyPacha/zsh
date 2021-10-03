# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=1000
setopt autocd
unsetopt beep
# set emacks like bindings
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pgusev/.zshrc'

# Add ssh creds
ssh-add ~/.ssh/{home,work}-main

autoload -Uz compinit ; compinit

setopt auto_param_slash
setopt complete_in_word

# autosuggestions plugin
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white,bg=grey"

# explore func
source ~/.config/zsh/explore.zsh
# vps func
source ~/.config/zsh/vps.zsh

# Prompt
precmd() {
    p_usr=%F{250}%n%f%F{81}@%f%F{250}%m%f\ 
    p_pwd=$(pwd)
    if [[ $(pwd) =~ 'devel[0-9]?' ]] {
        p_devel="%F{81}$(echo $p_pwd | rg -o 'devel[0-9]?')%f "
    } else {
        p_devel=''
    }
    p_dir=%F{250}%2~%f
    
    PROMPT="$p_usr$p_devel$p_dir $ "
}

# Aliases
alias config='nvim ~/.config/zsh/.zshrc'

alias vnin='nvim'
alias vnim='nvim'

