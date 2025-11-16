#!/bin/bash

# Creates (if needed) and configures a user with the project's Zsh setup.
# Author: Aden-M (Aden Mann)
# Version: 1.0
# Validated: false
# Date: 11/06/2025

set -e

if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be run as root to manage users and shells." >&2
  exit 1
fi

if [[ -z $1 ]]; then
  echo "Usage: $0 <username>" >&2
  exit 1
fi

TARGET_USER=$1
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
ZSH_SCRIPT="$SCRIPT_DIR/zsh.sh"

# Create the user if it doesn't exist
if ! id "$TARGET_USER" &>/dev/null; then
  echo "Creating user $TARGET_USER..."
  useradd -m -s /bin/bash "$TARGET_USER"
fi

chmod +x "$ZSH_SCRIPT"
"$ZSH_SCRIPT" "$TARGET_USER"

echo "User $TARGET_USER is configured with the custom Zsh setup."
