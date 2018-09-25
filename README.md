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

![](/readme_images/ansible_macos.png)

## Modification

Open `<ROLE>/vars/main.yml` then add your additional modification.

## Support status

macOS

Roles | Descriptions
---- | ----
bash_completion | bash completion symlinks
defaults | macos defaults
dotfiles | dotfiles
homebrew | homebrew packages
homebrew-cask | homebrew packages for GUI App
python | python environment setup. using pyenv and pyvirtualenv.
terraform | terraform environment setup. using tfenv.

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