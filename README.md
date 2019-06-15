# Ansible

[![Build Status](https://travis-ci.com/vghn/ansible.svg?branch=master)](https://travis-ci.com/vghn/ansible)

## Development status

This project is still in a prototype development stage.

## Overview

Ansible playbooks

## Ansible Control

### Install Ansible

Ubuntu

```sh
sudo apt update
sudo apt install -y software-properties-common git python3 python3-pip openssl
sudo apt-add-repository -y --update ppa:ansible/ansible
sudo apt-get install -y ansible
```

CentOS

```sh
sudo yum install -y epel-release
sudo yum install -y ansible
```

Mac

```sh
pip install ansible
```

Optional shared group permissions

```sh
sudo chown -R vlad:admins .
find . -type f -exec sudo chmod 664 {} \;
find . -type d -exec sudo chmod 775 {} \;
sudo setfacl -m g::rwx -m o::rx  .
sudo setfacl -m default:g::rwx -m o::rx  .
```

### Prepare Control Machine

```sh
ansible-playbook playbooks/control.yml
```

### Provision Ansible on node

```sh
ansible-playbook -u myuser --ask-pass --ask-become-pass playbooks/ansible.yml --limit mynode
# OR
ansible-playbook -u myuser --private-key key_rsa playbooks/ansible.yml --limit mynode
```

### Install / Update Galaxy Roles

```sh
ansible-galaxy install --force --role-file requirements.yml
```

### Run Ansible with default settings

```sh
ansible-playbook site.yml
```

### Edit Vault encrypted files

```sh
ansible-vault edit group_vars/all/vault
```

### Ping hosts

```sh
ansible all -m ping
```

### Run ad-hoc commands on hosts

```sh
# Where `all` is the group,`-b` is become sudo, `uptime` is the command)
ansible all -b -a uptime
```
