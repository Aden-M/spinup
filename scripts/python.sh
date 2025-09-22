#!/bin/bash

# Installs development environment tools to fulfill the requirements for a complete python development in WSL with Ubuntu.
# Author: Aden-M (Aden Mann)
# Version: 0.1
# Validated: false
# Date: 09/22/2025

set -e

# 1. Install All Neccessary system-wide Python Packages and tools.
sudo apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    python3-dev \
    python3-setuptools \
    python3-wheel \
    python3-distutils \
    build-essential \
    pkg-config \
    libffi-dev \
    libssl-dev \
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    libsqlite3-dev \