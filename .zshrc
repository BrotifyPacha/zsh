# Lines configured by zsh-newuser-install
export PATH="$PATH:/home/$USER/.config/composer/vendor/bin"
export PATH="$PATH:/home/$USER/.dotnet"
export PATH="$PATH:$(go env GOPATH)/bin"
export EDITOR=~/.local/bin/nvim
export TERM="xterm-kitty"

if [ $PWD = ~ ] ; then
    HISTFILE=~/.histfile
fi

setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

HISTSIZE=5000
SAVEHIST=5000

setopt globdots
setopt autocd
unsetopt beep
# set viins vi-insert mode by default
bindkey -v

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey -v '^[[3~'  delete-char
bindkey -v '^W' backward-delete-word
bindkey -v '^A' beginning-of-line
bindkey -v '^E' end-of-line
bindkey -v '^B' backward-word
bindkey -v '^F' forward-word

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pgusev/.zshrc'

# Add ssh creds
ssh-add ~/.ssh/{home,work}-main 2>/dev/null

setxkbmap -option "caps:escape"

autoload -Uz compinit ; compinit
autoload -Uz add-zsh-hook
autoload -U colors && colors

setopt auto_param_slash
setopt menu_complete
setopt complete_in_word

zmodload zsh/complist
zstyle ':completion:*' menu select=0 search

# To make this work, one has to do below mappings in kitty
# map shift+enter send_text all \x1b[13;2u
# map ctrl+enter send_text all \x1b[13;5u
bindkey -M menuselect '^M' .accept-line
bindkey -M menuselect '^[[13;2u' accept-line
bindkey -M menuselect '^N' history-incremental-search-forward
bindkey -M menuselect '^B' history-incremental-search-backward

# autosuggestions plugin
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777,bg=gray"

# config manager
source ~/.config/zsh/config.zsh
# aliases
source ~/.config/zsh/aliases.zsh

local username=%F{245}%n%f%F{81}@%f%F{245}%m%f
local last_two_dirs=%F{250}%2~%f
export PROMPT=$username\ $last_two_dirs$'\n'\$\ 

wmname LG3D

## Node version manager
## Commented for performance reason
## uncomment when needed
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# [[ "$PATH" == *"$HOME/bin:"* ]] || export PATH="$HOME/bin:$PATH"

# Werf
! { which werf | grep -qsE "^/home/brotifypacha/.trdl/"; } && [[ -x "$HOME/bin/trdl" ]] && source $("$HOME/bin/trdl" use werf "1.2" "stable")
# Kubectl
alias k=kubectl
source <(kubectl completion zsh)
