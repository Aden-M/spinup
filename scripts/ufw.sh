#!/bin/bash
set -e
echo "Allowing SSH"
sudo ufw allow 22/tcp
echo "Settings Default Policies"
sudo ufw default deny incoming
sudo ufw default allow outgoing
echo "Enabling Logging"
sudo ufw logging on
echo "Enalbing UFW"
sudo ufw --force enable
echo "Firewall Status:"
sudo ufw status verbose
