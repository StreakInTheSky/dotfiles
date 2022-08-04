#!/bin/sh

echo "Installing Developer tools for Mac"
eval "$(xcode-select --install)"

echo "\nInstalling Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "\nInstalling from Brewfile"
curl -sSL https://raw.githubusercontent.com/StreakInTheSky/dotfiles/master/Brewfile | brew bundle --file=- 

echo "\nCloning dotfiles repo"
git clone https://github.com/StreakInTheSky/dotfiles.git ~/.dotfiles

echo "\nSetting up fzf"
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-bash --no-fish --no-update-rc

echo "\nCreating .zfunc directory"
mkdir ~/.zfunc

echo "\nConfiguring .zshrc with defaults"
echo "source ~/.dotfiles/zshrc_defaults" >> ~/.zshrc
zsh -c "source ~/.zshrc"

echo "\nInstalling nvm and node"
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"
zsh -i -c "nvm install --lts"

echo "\nInstalling python"
curl -sSL https://install.python-poetry.org | python3 -
poetry completions zsh > ~/.zfunc/_poetry
zsh -i -c "npm i -g pyright"

echo "\nInstalling rust" 
curl https://sh.rustup.rs -sSf | sh -s -- -y
rustup completions zsh > ~/.zfunc/_rustup
rustup update nightly

echo "\nCreating symlinks to config files"
zsh ~/.dotfiles/link.zsh

echo "\nInstalling Neovim Plugins"
nvim -e +PlugInstall +qa

echo "\nAdding wezterm terminfo"
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
  && sudo tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

