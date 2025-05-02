#!/bin/bash

# Allows user to enter desired hostname
# Author: Aden-M (Aden Mann)
# Date: 04/30/2025

set -e

while true; do 
    read -p "Enter Desired Hostname: " hostname
    read -p "Is $hostname your desired hostname? (Y/n): " confirmation
    if [[ -z "$input" || "$input" =~ ^[Yy]$ ]]; then
        if sudo hostnamectl set-hostname "$hostname" && \
           sudo sed -i "s/^127.0.1.1.*/127.0.1.1\t$hostname/" /etc/hosts; then
           echo "$hostname has been applied as the system hostname."
           break
        else
            echo "Error: Failed to set $hostname as the system hostname," >&2
        fi
    fi
done
    