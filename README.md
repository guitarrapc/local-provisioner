# local-provisioner

Dev environment setup.

Environment | Version | Method
---- | ---- | ----
macOS | Intel BigSurf | Ansible Playbook
macOS-silicon | ARM BigSurf | Ansible Playbook
Windows | 10 2020 May Update| scoop
Ubuntu | 20.04<br/>18.04<br/>WSL1<br/>WSL2 | Ansible Playbook
Ubuntu WSL2 | Ubuntu 20.04 WSL2 (install docker on wsl2) | Ansible Playbook

## Run

clone repo setup.

```shell
mkdir -p ~/github/guitarrapc && cd ~/github/guitarrapc
git clone https://github.com/guitarrapc/local-provisioner
```

Ubuntu, run ansible-playbook.

```shell
cd ~/github/guitarrapc/local-provisioner/envs/ubuntu
. ./prerequisites.sh
exec $SHELL -l
. ./run.sh
```

![image](https://user-images.githubusercontent.com/3856350/67872931-0465bd80-fb76-11e9-8700-bdc0e861f556.png)

macOS, run ansible-playbook.

```shell
cd ~/github/guitarrapc/local-provisioner/envs/macos
. ./prerequisites.sh
exec $SHELL -l
. ./run.sh
```

![image](https://user-images.githubusercontent.com/3856350/67872838-dda78700-fb75-11e9-9073-a4cc0f37e6d1.png)

Windows 10, run scoop-playbook.

```shell
cd ~/github/guitarrapc/local-provisioner/envs/windows
. ./prerequisites.ps1
. ./run.ps1
```

![image](https://user-images.githubusercontent.com/3856350/67872580-84d7ee80-fb75-11e9-8c1c-e7d25fc94892.png)

## Test

### macOS only!!

If you need spec, use ansible_spec.
run test at env.

```shell
cd envs/macos
# check tests
bundle exec rake -T
# run all tests
bundle exec rake all
```

## Support status

### Ubuntu

include Ubuntu 20.04, 18.04 and on WSL1, WSL2.

Role | Descriptions
---- | ----
credentials | link credentials on Windows. When it's WSL1 or WSL2.
debug | ansible status debugger.
docker | install docker. when it's not WSL2.
dotfiles | link with [dofiles-linux](https://github.com/guitarrapc/dotfiles-linux)
tools | miscellaneous tools setup.

### macOS

Role | Descriptions
---- | ----
bash_completion | bash completion symlinks
defaults | macos defaults
dotfiles | link with [dofiles](https://github.com/guitarrapc/dotfiles)
homebrew | homebrew packages
homebrew-cask | homebrew packages for GUI App
homebrew-cask-fonts | homebrew packages for fonts
kubernetes | kubernetes related
node | node.js/npm/npmpackages setup. using nodebrew/npm.
pam | pam module for touchid
python | python environment setup. using pyenv and pyvirtualenv.
ruby | ruby environment setup. using rbenv and just install bundler.
terraform | terraform environment setup. using tfenv.

* Out of scope: Each Unity Editor

### Windows

Role | Descriptions
---- | ----
dotfiles | NOT YET. link with [dofiles-win](https://github.com/guitarrapc/dotfiles-win)
scoop_current | install app via scoop's `current` bucket
scoop_current | install app via scoop's `extras` bucket

Out of scopes

* Docker for Windows.
* Visual Studio 2017 or higher.
* .NET Core SDK
* Each Unity Editor

## How to modify

Folk this repository.

macOS will change by modify followings.

* Modify parameters by open `envs/macos/roles/<role>/vars/main.yml`.
* Modify logic by open `envs/macos/roles/<role>/tasks/main.yml`.

Windows will change by modify followings.

* Modify parameters by open `envs/windows/roles/<role>/tasks/main.yml`.

macOS / Ubuntu will change by modify followings.

* Modify parameters by open `envs/ubuntu/roles/<role>/vars/main.yml`.
* Modify logic by open `envs/ubuntu/roles/<role>/tasks/main.yml`.

## Issues

### Ubuntu

* Ansible apt_key always show changed: https://github.com/ansible/ansible/issues/27798
* get_url is not controlable or too match differ from original context, so it's warning is ignored.
