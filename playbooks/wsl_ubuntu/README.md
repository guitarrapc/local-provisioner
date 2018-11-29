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