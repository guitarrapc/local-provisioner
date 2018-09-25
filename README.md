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
ruby | ruby environment setup. using rbenv and just install bundler.
terraform | terraform environment setup. using tfenv.

Windows

[TODO]

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