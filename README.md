# Ansible

[![Build Status](https://travis-ci.com/vghn/ansible.svg?branch=master)](https://travis-ci.com/vghn/ansible)

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
ansible-playbook -u vlad --ask-pass --ask-become-pass ansible.yml --limit mynode
# if ssh errors
ansible-playbook -c paramiko -u vlad --ask-pass --ask-become-pass playbooks/ansible.yml --limit mynode
# OR
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

## Run ad-hoc commands on hosts

```sh
# Wher `all` is the group,`-b` is become sudo, `uptime` is the command)
ansible all -b -a uptime
```

### Run locally

```sh
ansible-playbook --connection=local site.yml
```
