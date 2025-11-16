#!/bin/bash

# Sets up zsh with a custom .zshrc and useful plugins.
# Author: Aden-M (Aden Mann)
# Version: 1.2
# Validated: false
# Date: 11/06/2025

set -e

if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be run as root so it can install packages and set default shells." >&2
  exit 1
fi

# Determine where this script lives and where the repo root is
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
ZSH_SOURCE_DIR="$REPO_ROOT/zsh"

# Target user to configure (defaults to the sudo caller or current user)
TARGET_USER=${1:-${SUDO_USER:-$USER}}
if ! id "$TARGET_USER" &>/dev/null; then
  echo "Target user '$TARGET_USER' does not exist." >&2
  exit 1
fi
TARGET_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
PLUGINS_DIR="$TARGET_HOME/.zsh/plugins"
ZSH_SHELL="$(command -v zsh)"

# Helper to run commands as the target user
run_as_target() {
  sudo -u "$TARGET_USER" bash -c "$*"
}

# 1. Install required packages
apt update
apt install -y zsh git curl

# 2. Make zsh the default shell for the target user
chsh -s "$ZSH_SHELL" "$TARGET_USER"
echo "Installed zsh and set as default shell for $TARGET_USER."

# 3. Copy your custom .zshrc from the repo
install -m 644 "$ZSH_SOURCE_DIR/.zshrc" "$TARGET_HOME/.zshrc"
chown "$TARGET_USER":"$TARGET_USER" "$TARGET_HOME/.zshrc"
echo "Copied .zshrc to $TARGET_HOME."

# 4. Install plugins
run_as_target "mkdir -p '$PLUGINS_DIR'"
install_plugin() {
  local repo_url=$1
  local dest_dir=$2

  if [[ -d "$dest_dir/.git" ]]; then
    run_as_target "cd '$dest_dir' && git pull --ff-only"
  else
    run_as_target "git clone '$repo_url' '$dest_dir'"
  fi
}

install_plugin https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
install_plugin https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"
install_plugin https://github.com/marlonrichert/zsh-autocomplete "$PLUGINS_DIR/zsh-autocomplete"
echo "Installed zsh plugins for $TARGET_USER."
