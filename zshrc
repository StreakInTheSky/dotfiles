# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit -C
# End of lines added by compinstall

autoload -U promptinit; promptinit
#prompt pure

function () {
local OS=$(uname)

# Different paths for different OS
case $OS in
Darwin)
    PATH=/usr/local/opt/python/libexec/bin:$PATH # symlinks python3 as python
    PATH=$PATH:~/.composer/vendor/bin # allows laravel to be executable
    ;;
Linux)
    PATH=$PATH:/usr/local/go/bin # add Go tools
    ;;
esac

export PATH

export NVM_LAZY_LOAD=true
source ~/.zsh_plugins.sh

#aliases
case $OS in 
Darwin)
    alias ls='ls -G'
    ;;
Linux)
    alias ls='ls --color=auto'
    ;;
esac
}

