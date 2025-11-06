#!/bin/bash

# Calls and executes a series of setup scripts.
# Author: Aden-M (Aden Mann)
# Date: 08/22/2025

# Exit Upon Failure
set -e

# Define the working directory
WDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$WDIR"

# Make all scripts executable
for script in ./scripts/*.sh; do
    chmod +x "$script"
    echo "Made executable: $script"
done

# Execute all scripts
./scripts/zsh.sh
./scripts/docker.sh
#./scripts/ufw.sh
#/./scripts/ssh.sh
./scripts/cxx.sh
./scripts/python.sh
