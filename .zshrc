# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=1000
setopt autocd
unsetopt beep
# set emacks like bindings
bindkey -e

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pgusev/.zshrc'

# Add ssh creds
ssh-add ~/.ssh/{home,work}-main 2>/dev/null

EDITOR=nvim
TERM=xterm-256color
setxkbmap -option "caps:swapescape"

autoload -Uz compinit ; compinit

setopt auto_param_slash
setopt menu_complete
setopt complete_in_word

zmodload zsh/complist
zstyle ':completion:*' menu select=0 search

# autosuggestions plugin
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777,bg=gray"

# explore func
source ~/.config/zsh/explore.zsh
# vps func
source ~/.config/zsh/vps.zsh
# config manager
source ~/.config/zsh/config.zsh

# Prompt
precmd() {
    p_usr=%F{250}%n%f%F{81}@%f%F{250}%m%f\ 
    p_pwd=$(pwd)
    if [[ $(pwd) =~ 'devel[0-9]?|embla|fenrir' ]] {
        p_devel="%F{81}$(echo $p_pwd | rg -o 'devel[0-9]?|embla|fenrir')%f "
    } else {
        p_devel=''
    }
    p_dir=%F{250}%2~%f
    
    PROMPT="$p_usr$p_devel$p_dir $ "
}

# Aliases
source ~/.config/zsh/aliases.zsh


