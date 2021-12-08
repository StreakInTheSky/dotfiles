#!/bin/sh

echo "Installing Developer tools for Mac"
eval "$(xcode-select --install)"

echo "\nInstalling Homebrew"
/bin/bash -c "$(curl -sSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "\nInstalling from Brewfile"
curl -sSL https://raw.githubusercontent.com/StreakInTheSky/dotfiles/master/Brewfile | brew bundle --file=- 

echo "\nCloning dotfiles repo"
git clone https://github.com/StreakInTheSky/dotfiles.git ~/.dotfiles

echo "\nInstalling zsh plugins with antibody"
antibody bundle < ~/.dotfiles/zsh_plugins.txt > ~/.zsh_plugins.sh

echo "\nSetting up fzf"
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-bash --no-fish --no-update-rc

echo "\nCreating .zfunc directory"
mkdir ~/.zfunc

echo "\nConfiguring .zshrc with defaults"
echo "source ~/.dotfiles/zshrc_defaults" >> ~/.zshrc
zsh -c "source ~/.zshrc"

echo "\nInstalling node"
zsh -i -c "nvm install --lts"

echo "\nInstalling python"
git clone https://github.com/momo-lab/pyenv-install-latest.git "$(pyenv root)"/plugins/pyenv-install-latest
pyenv install-latest
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
poetry completions zsh > ~/.zfunc/_poetry
zsh -i -c "npm i -g pyright"

echo "\nInstalling rust" 
curl https://sh.rustup.rs -sSf | sh -s -- -y
rustup completions zsh > ~/.zfunc/_rustup
rustup update nightly
rustup +nightly component add rust-analyzer-preview

echo "\nCreating symlinks to config files"
zsh ~/.dotfiles/link.zsh

echo "\nInstalling Neovim Plugins"
nvim -e +PlugInstall +qa

echo "\nAdding wezterm terminfo"
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
  && sudo tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

