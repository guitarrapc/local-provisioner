## WSL_UBUNTU

use ansible to configure local-dev.

### Install

```bash
sudo apt-get update
sudo apt-get install ansible
```

### Run

run following to setup execution environment.

```bash
bash
cd ansible/playbooks/ubuntu/
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