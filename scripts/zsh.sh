#!/bin/bash

# Sets up zsh with a custom .zshrc and useful plugins.
# Author: Aden-M (Aden Mann)
# Version: 1.1
# Validated: false
# Date: 11/06/2025

set -e 

# Determine where this script lives and where the repo root is
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
ZSH_SOURCE_DIR="$REPO_ROOT/zsh"
PLUGINS_DIR="$HOME/.zsh/plugins"


# 1. Install required packages
sudo apt update
sudo apt install -y zsh git curl

# 2. Make zsh the default shell
chsh -s "$(which zsh)"
echo "Installed zsh and set as default shell."

# 4. Copy your custom .zshrc from the repo
cp "$ZSH_SOURCE_DIR/.zshrc" "$HOME/.zshrc"
echo "Copied .zshrc to home directory."

# 6. Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$PLUGINS_DIR/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    "$PLUGINS_DIR/zsh-syntax-highlighting"
git clone https://github.com/marlonrichert/zsh-autocomplete \
    "$PLUGINS_DIR/zsh-autocomplete"
echo "Installed zsh plugins."
