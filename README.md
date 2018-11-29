# local-provisioner

Dev environment setup with Ansible Playbook.

- [x] macOS (Mojave, High Sierra)
- [ ] Windows 10
- [x] Ubuntu : Bash on Windows Subsystem for Linux (WSL)

## How to Run

### Prerequisites

before run provisioner, make sure you have installed ansible.

macOS.

```shell
. ./scripts/macos/install_commandlinetools.sh
. ./scripts/macos/install_homebrew.sh
. ./scripts/macos/install_ansible.sh
```

Windows, not yet.

[TODO]

Ubuntu : Bash on WSL.

```shell
. ./scripts/wsl_ubuntu/install_ansible.sh
```

### Run Provisioner

Move to `playbooks/<env>`, then run ansible-playbook.

macOS.

```shell
cd playbooks/macos
ansible-playbook -i hosts site.yml
```

![](/readme_images/ansible_macos.png)

Windows, not yet.

[TODO]

Ubuntu : Bash on WSL.

```shell
cd playbooks/wsl_ubuntu
ansible-playbook -i hosts site.yml --ask-sudo-pass
```

### How to modify

Folk this repository.

* Modify parameters by open `playbooks/<env>/<role>/vars/main.yml`.
* Modify logic by open `playbooks/<env>/<role>/tasks/main.yml`.

## Support status

macOS.

Role | Descriptions
---- | ----
bash_completion | bash completion symlinks
defaults | macos defaults
dotfiles | dotfiles
homebrew | homebrew packages
homebrew-cask | homebrew packages for GUI App
node | node.js/npm/npmpackages setup. using nodebrew/npm.
python | python environment setup. using pyenv and pyvirtualenv.
ruby | ruby environment setup. using rbenv and just install bundler.
terraform | terraform environment setup. using tfenv.

Windows.

[TODO]

Ubuntu : Bash on WSL.

Role | Descriptions
---- | ----
awscli | awscli setup.
azcli | azure cli setup.
direnv | direnv setup.
docker | docker environment setup.
dotfiles | dotfiles
python | python environment setup. using pyenv and pyvirtualenv.
terraform | terraform environment setup. using tfenv.
tools | miscellaneous tools setup.

## Spec

If you need spec, use ansible_spec.
Run following to configure ansible_spec.

```shell
. ./scripts/macos/init_ansiblespec.sh
```

run test at env.

```shell
cd playbooks/macos
# check tests
bundle exec rake -T
# run all tests
bundle exec rake all
```