#!/bin/bash

#Exit Upon Failure
set -e

SPINUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SPINUP"

for script in ./scripts/*.sh; do
    chmod +x "$script"
    echo "Made executable: $script"
done

#./scripts/zsh-helper.sh
./scripts/zsh.sh
./scripts/docker.sh
./scripts/ssh.sh

