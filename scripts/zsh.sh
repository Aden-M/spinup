#!/bin/bash
set -e

# Resolve the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
THEME_NAME="adenm.zsh-theme"

# Install required packages
sudo apt update && sudo apt install -y zsh git curl

# Set zsh as the default shell
chsh -s "$(which zsh)"
echo "Installed zsh and set as default shell."

# Install Oh My Zsh (non-interactive)
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Installed Oh My Zsh."

# Copy custom .zshrc
cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
echo "Copied .zshrc to home directory."

# Copy custom theme
mkdir -p "$ZSH_CUSTOM/themes"
cp "$SCRIPT_DIR/$THEME_NAME" "$ZSH_CUSTOM/themes/"
echo "Installed custom theme: $THEME_NAME."

# Install optional plugins
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/marlonrichert/zsh-autocomplete "$ZSH_CUSTOM/plugins/zsh-autocomplete"
echo "Installed zsh plugins."

echo "Zsh setup complete. Launch a new shell or run 'zsh' to start using it."
