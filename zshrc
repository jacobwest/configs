
# check out http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/ for inspiration
# and https://github.com/spicycode/ze-best-zsh-config

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# setopt appendhistory autocd extendedglob nomatch
setopt autocd extendedglob nomatch
unsetopt beep notify
unsetopt inc_append_history
unsetopt share_history
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/jrw/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source ~/.zsh/aliases.zsh

#export PATH=$HOME/.local/bin:$PATH

