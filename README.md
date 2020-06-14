# Ansible

![Build Status](https://github.com/vghn/ansible/workflows/CI/badge.svg)

## Development status

This project is still in a prototype development stage.

## Overview

Vlad's Ansible

## Install Ansible

Ubuntu

```sh
sudo apt update && sudo apt install -y software-properties-common
sudo apt-add-repository -y --update ppa:ansible/ansible
sudo apt-get install -y ansible
```

CentOS

```sh
sudo yum install -y epel-release
sudo yum install -y ansible
```

Python

```sh
python3 -m pip install --user --upgrade ansible
```

Optional shared group permissions

```sh
sudo chown -R vlad:admins .
find . -type f -exec sudo chmod 664 {} \;
find . -type d -exec sudo chmod 775 {} \;
sudo setfacl -m g::rwx -m o::rx  .
sudo setfacl -m default:g::rwx -m o::rx  .
```

## Provision Ansible on node

```sh
# become root
ansible-playbook -u vlad --ask-pass --ask-become-pass playbooks/ansible.yml --limit mynode
# with ssh library
ansible-playbook -c paramiko -u vlad --ask-pass --ask-become-pass playbooks/ansible.yml --limit mynode
# with private key
ansible-playbook -u myuser --private-key key_rsa playbooks/ansible.yml --limit mynode
```

## Install / Update Galaxy Roles

```sh
ansible-galaxy install --force --role-file requirements.yml
```

## Run Ansible with default settings

```sh
ansible-playbook site.yml
```

## Edit Vault encrypted files

<https://docs.ansible.com/ansible/latest/user_guide/vault.html>

```sh
# Add `vault_password_file = ./ansible_vault_pwd` to ansible.cfg and create `ansible_vault_pwd` containing the password
ansible-vault edit group_vars/all/vault
```

## Ping hosts

```sh
ansible all -m ping
```

## Contribute

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-007ba7.svg)](https://www.contributor-covenant.org/version/2/0/code_of_conduct.html)

Contributions are always welcome! Please read the [contribution guidelines](.github/CONTRIBUTING.md) and the [code of conduct](.github/CODE_OF_CONDUCT.md).

## License
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Licensed under the Apache License, Version 2.0.
See [LICENSE](LICENSE) file.
