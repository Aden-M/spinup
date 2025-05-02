#!/usr/bin/env bash

# Sets up ZSH/OMZ from given .zshrc, adenm.zsh-theme files
# Author: Aden-M (Aden Mann)
# Date: 04/30/2025
set -e

# Determine where this script lives and where the repo root is
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
ZSH_SOURCE_DIR="$REPO_ROOT/zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
THEME_NAME="adenm.zsh-theme"

# 1. Install required packages
sudo apt update
sudo apt install -y zsh git curl

# 2. Make zsh the default shell
chsh -s "$(which zsh)"
echo "Installed zsh and set as default shell."

# 3. Install Oh My Zsh non-interactively
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Installed Oh My Zsh."

# 4. Copy your custom .zshrc from the repo
cp "$ZSH_SOURCE_DIR/.zshrc" "$HOME/.zshrc"
echo "Copied .zshrc to home directory."

# 5. Install your custom theme
mkdir -p "$ZSH_CUSTOM/themes"
cp "$ZSH_SOURCE_DIR/custom/themes/$THEME_NAME" "$ZSH_CUSTOM/themes/"
echo "Installed custom theme: $THEME_NAME."

# 6. Install optional plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/marlonrichert/zsh-autocomplete \
    "$ZSH_CUSTOM/plugins/zsh-autocomplete"
echo "Installed zsh plugins."

echo "Zsh setup complete. Start a new shell or run 'zsh' to verify."
