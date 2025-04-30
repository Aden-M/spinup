#!/bin/bash
sudo apt update && sudo apt install -y zsh

chsh -s "$(which zsh)"
echo "Installed zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Installed ohmyzsh"
cp ./.zshrc ~/.zshrc
echo "Copied .zshrc"

THEME_NAME="adenm.zsh-theme"
THEME_PATH="./$THEME_NAME"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
cp "$THEME_PATH" "$ZSH_CUSTOM/themes/"
echo "Installed custom theme"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
