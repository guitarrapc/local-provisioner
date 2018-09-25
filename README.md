# local-provisioner

Dev environment setup with Ansible Playbook.

- [x] macOS (Mojave, High Sierra)
- [ ] Windows 10

## How to Run

### Prerequisites

macOS, Run following to configure ansible.

```shell
. ./scripts/macos/install_commandlinetools.sh
. ./scripts/macos/install_homebrew.sh
. ./scripts/macos/install_ansible.sh
```

Windows, not yet.

[TODO]

### Run Provisioner

Move to `playbooks/<env>`, then run ansible-playbook.

```shell
cd playbooks/macos
ansible-playbook -i hosts site.yml
```

![](/readme_images/ansible_macos.png)

### How to modify

Folk this repository.

* Modify parameters by open `playbooks/<env>/<role>/vars/main.yml`.
* Modify logic by open `playbooks/<env>/<role>/tasks/main.yml`.


## Support status

macOS

Role | Descriptions
---- | ----
bash_completion | bash completion symlinks
defaults | macos defaults
dotfiles | dotfiles
homebrew | homebrew packages
homebrew-cask | homebrew packages for GUI App
node | node.js/npm/npmpackages setup. using nodebrew/npm.
python | python environment setup. using pyenv and pyvirtualenv.
terraform | terraform environment setup. using tfenv.

Windows

[TODO]
