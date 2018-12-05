#!/usr/bin/env bash
# Bootstrap script

# Usage:
# $ curl -fsSL https://raw.githubusercontent.com/vghn/ansible/master/bootstrap.sh | sudo bash

# **Note:** Our code is completely open, but piping to bash can be dangerous and is not recommended for production systems. For a safer install, review the code and then run the installer locally.

# Bash strict mode
set -euo pipefail
IFS=$'\n\t'

# DEBUG
[ -z "${DEBUG:-}" ] || set -x

# Create deploy user
id -u deploy &>/dev/null || sudo useradd -m -s /bin/bash -U deploy

#  Add authorized_key
key='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+4vPJ554LgwIZ7qK2DoipJe9U2yuRwUZpTtjJ4EHqASn+KUbWX8XA7ipwLloQiWO25U5S4UjAxy3jcd2ykkQWD2XeXnE9qZZTgRAJfOpTKNIlng7NBPg9gHJcUADU8EXTd52sYQRl67inQpExb9TnshAAmrShh2T2cVqzybLdHbukchEHRUgKINp/Ci/zPffhv7yWKz4EUzvZdisRVgd3tuHJotvrHk18OOhSaGGlcuiig2AQgpd4MV7+yyyYoT0keOPiRrf3OAAnFMzaQbaoekDvwRg8GmCY3oFZVzsxehB+jTGj1ICz60L8qTN2oeD6zOw1EQWOQldNw5TnTuUz deploy'
grep -q "$key" /home/deploy/.ssh/authorized_keys || (
  sudo -u deploy mkdir -p /home/deploy/.ssh
  echo "$key" | sudo -u deploy tee -a /home/deploy/.ssh/authorized_keys
  sudo chmod 700 /home/deploy/.ssh
  sudo chmod 600 /home/deploy/.ssh/authorized_keys
)

# Add user to sudoers
echo 'deploy ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/00_deploy
sudo chmod 440 /etc/sudoers.d/00_deploy
