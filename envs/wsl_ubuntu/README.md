## WSL_UBUNTU

use ansible to configure local-dev.

```
$ cat /etc/os-release | egrep "NAME=|VERSION="

NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```

### Install

```bash
sudo apt-get update
sudo apt upgrade -y
sudo apt-get install ansible -y
```

### Run

run following to setup execution environment.

```bash
bash
cd envs/wsl_ubuntu
ansible-playbook -i hosts site.yml --ask-become-pass
```
