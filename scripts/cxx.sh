#!/bin/bash

# Installs development environment tools to fulfill the requirements for a complete C++ development in WSL with Ubuntu.
# Author: Aden-M (Aden Mann)
# Version: 0.2
# Validation: false
# Date: 09/22/2025

set -e

# 1. Install Required Build Tools.
sudo apt-get install build-essential gdb -y