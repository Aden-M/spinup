#!/bin/bash

# Sets up sensible fail2ban to guard against brute-force ssh attempts
# Author: Aden-M (Aden Mann)
# Date: 05/01/2025

set -e
sudo apt update

# Install and enable fail2ban
sudo apt install fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Resolve the Working Directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="$REPO_ROOT/secrets"

# Set f2b-ssh.conf
SSH_CONF="$CONFIG_DIR/f2b-ssh.conf"

# Move f2b-ssh.conf to the jail.d folder
sudo cp $SSH_CONF /etc/fail2ban/jail.d/ssh.conf

# Enroll ssh.conf
sudo systemctl restart fail2ban

# Echo the working state of fail2ban
sudo echo fail2ban-client status 





