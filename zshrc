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

# Different paths for different OS
case $(uname) in
Darwin)
    export PATH=/usr/local/opt/python/libexec/bin:$PATH # symlinks python3 as python
    export PATH=$PATH:~/.composer/vendor/bin # allows laravel to be executable
    ;;
Linux)
    export PATH=$PATH:/usr/local/go/bin # add Go tools
    ;;
esac

export NVM_LAZY_LOAD=true
source ~/.zsh_plugins.sh

#aliases
case $(uname) in 
Darwin)
    alias ls='ls -G'
    ;;
Linux)
    alias ls='ls --color=auto'
    ;;
esac

