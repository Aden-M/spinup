#!/bin/bash

# Adds SSH public keys to the authorized keys of the user running this script
# Author: Aden-M (Aden Mann)
# Date: 04/30/2025

set -e

# Resolve the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SECRETS_DIR="$REPO_ROOT/secrets"
PUBKEY_FILE="$SECRETS_DIR/pubkey.secrets"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

cat "$PUBKEY_FILE" >> "$HOME/.ssh/authorized_keys"
chmod 600 "$HOME/.ssh/authorized_keys"

echo "Installed SSH public key(s) from $PUBKEY_FILE"