#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# DEBUG
[ -z "${DEBUG:-}" ] || set -x

# Update APT
sudo apt-get update

# Install Python
sudo apt-get -qy install python-minimal

# Create deploy user
id -u deploy &>/dev/null || sudo useradd -m -s /bin/bash -U deploy

#  Add authorized_key
key='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEcgOJRwnx/+oY/s4k/NkSYDEKCjHVm1cwkhFFVTDuBq Deploy'
grep -q "$key" /home/deploy/.ssh/authorized_keys || (
  sudo -u deploy mkdir -p /home/deploy/.ssh
  echo "$key" | sudo -u deploy tee -a /home/deploy/.ssh/authorized_keys
  sudo chmod 700 /home/deploy/.ssh
  sudo chmod 600 /home/deploy/.ssh/authorized_keys
)

# Add user to sudoers
echo 'deploy ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/00_deploy
sudo chmod 440 /etc/sudoers.d/00_deploy
