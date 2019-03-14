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
ansible-playbook -i hosts site.yml --ask-sudo-pass
```

## bashrc and .bash_profile

if you want upddate ~/bashrc and ~/.bash_profile, change `site.yml` variable.

from

```yaml
  vars:
    - update_bashrc: false
    - update_bashprofile: false
```

to 

```yaml
  vars:
    - update_bashrc: true
    - update_bashprofile: true
```

But it may update github:guitarrapc/dotfile item, so I recommend not to update by ansible.