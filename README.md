# local-provisioner

Dev environment setup with Ansible Playbook.

- [x] macOS High Sierra
- [ ] Windows 10

## How to run

Move to env, then run ansible-playbook.

```shell
cd playbooks/macos
ansible-playbook -i hosts site.yml
```

## Modification

Open `<ROLE>/vars/main.yml` then add your additional modification.

## Support status

macOS

Roles | Descriptions
---- | ----
base | macos defaults
bash_completion | bash completion symlinks
homebrew | homebrew packages
homebrew-cask | homebrew packages for GUI App
python | python environment setup. using pyenv and pyvirtualenv.

Windows

[TODO]

## Prerequisite

macOS, Run following to configure ansible.

```shell
. ./scripts/macos/install_homebrew.sh
. ./scripts/macos/install_ansible.sh
```

Windows, not yet.

[TODO]