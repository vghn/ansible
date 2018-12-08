# Ansible

[![Build Status](https://travis-ci.com/vghn/ansible.svg?branch=master)](https://travis-ci.com/vghn/ansible)

## Development status

This project is still in a prototype development stage.

## Overview

Vlad's Ansible playbooks

## SSH Deploy Key

Create encryption key and upload it to TravisCI

```sh
export ENCRYPT_KEY="$(echo "MyVeryStrongPassphrase" | base64)"
travis env set ENCRYPT_KEY "$ENCRYPT_KEY" --private --com
```

Encrypt the deploy ssh key

```sh
( echo "$ENCRYPT_KEY" | base64 --decode ) | gpg --symmetric --passphrase-fd 0 --batch --yes --cipher-algo AES256 --s2k-digest-algo SHA512 --output deploy_rsa.gpg ~/.ssh/deploy_rsa
```

Decrypt the deploy ssh key

```sh
( echo "$ENCRYPT_KEY" | base64 --decode ) |  gpg --batch --yes --decrypt --passphrase-fd 0 --output ~/.ssh/deploy_rsa deploy_rsa.gpg
```

## Contribute

See [CONTRIBUTING.md](CONTRIBUTING.md) file.

## License

Licensed under the Apache License, Version 2.0.
See [LICENSE](LICENSE) file.
