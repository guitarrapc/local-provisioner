# local-provisioner

Dev environment setup.

Status | Environment | Method
---- | ---- | ----
done | macOS (Mojave, High Sierra) | Ansible Playbook
done | Windows 10 | scoop
done | Ubuntu : Bash on Windows Subsystem for Linux (WSL) | Ansible Playbook

## How to Run

### Prerequisites

before run provisioner, make sure you have installed ansible.

macOS.

```shell
. ./prerequisites/macos/install_commandlinetools.sh
. ./prerequisites/macos/install_homebrew.sh
. ./prerequisites/macos/install_ansible.sh
```

Windows.

```shell
. ./prerequisites/windows/install_scoop.ps1
```


Ubuntu : Bash on WSL.

```shell
bash
. ./prerequisites/wsl_ubuntu/install_ansible.sh
```

### Run Provisioner


macOS, run ansible-playbook.

```shell
cd envs/macos
ansible-playbook -i hosts site.yml
```

![](/readme_images/ansible_macos.png)

Windows, run scoop.

```shell
cd envs/windows
./scoop-playbook.ps1
```

![](/readme_images/scoop_windows.png)

Ubuntu, Bash on WSL, run ansible-playbook.

```shell
bash
cd envs/wsl_ubuntu
ansible-playbook -i hosts site.yml --ask-sudo-pass
```

### How to modify

Folk this repository.

macOS will change by modify followings.

* Modify parameters by open `envs/macos/roles/<role>/vars/main.yml`.
* Modify logic by open `envs/macos/roles/<role>/tasks/main.yml`.

Windows will change by modify followings.

* Modify parameters by open `envs/windows/roles/<role>/tasks/main.yml`.

macOS / Ubuntu will change by modify followings.

* Modify parameters by open `envs/wsl_ubuntu/roles/<role>/vars/main.yml`.
* Modify logic by open `envs/wsl_ubuntu/roles/<role>/tasks/main.yml`.

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

Role | Descriptions
---- | ----
[dotfiles] | **NOT YET**
scoop_current | install app via scoop's `current` bucket
scoop_current | install app via scoop's `extras` bucket

Ubuntu : (Bash on WSL)

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

### macOS / WSL only!!

If you need spec, use ansible_spec.
Run following to configure ansible_spec.

```shell
. ./prerequisites/macos/init_ansiblespec.sh
```

run test at env.

```shell
cd envs/macos
# check tests
bundle exec rake -T
# run all tests
bundle exec rake all
```