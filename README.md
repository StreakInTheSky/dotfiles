# My dev environment

Setup new machine (MacOS only)

```
/bin/sh -c "$(curl -sSL https://raw.githubusercontent.com/StreakInTheSky/dotfiles/master/setup.sh)"
```

## Symlinks
To symlink files (will append ".old" to any conflicting files/directories)
```
# all files and directories in .dotfiles/home and .dotfiles/config
. ~/.dotfiles/link.zsh

# can also symlink one off files along with those directories
. ~/.dotfiles/link.zsh && symlink path/to/file /dir/to/put/link "name-of-link"
```

## Other useful commands
To change theme from light/dark (for WezTerm)
```
#Dark
theme

#Light
theme "light"

#To autoswitch based on macOS theme, source ~/.zshrc
. ~/.zshrc
```

Alternatives to common commands
```
bat # instead of cat/less
z # instead of cd
glow # for markdown files
rg # for grep or find. Pipe into fzf for refining search
```

