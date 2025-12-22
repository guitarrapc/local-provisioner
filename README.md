[![ansible lint](https://github.com/guitarrapc/local-provisioner/actions/workflows/ansible-lint.yaml/badge.svg)](https://github.com/guitarrapc/local-provisioner/actions/workflows/ansible-lint.yaml) [![install](https://github.com/guitarrapc/local-provisioner/actions/workflows/install.yaml/badge.svg)](https://github.com/guitarrapc/local-provisioner/actions/workflows/install.yaml)

# local-provisioner

Dev environment setup.

| Environment | Version | Method | Note |
| ---- | ---- | ---- | ---- |
| [macOS](envs/macos/README.md) | Sequoia(15.0)<br/>Sonoma(14.0) | Ansible Playbook | Target to Apple Silicon and Intel. |
| [Ubuntu](envs/ubuntu/README.md) | 24.04 (WSL1/WSL2)<br/>22.04 (WSL1/WSL2) | Ansible Playbook | install docker on wsl2. |
| [Windows](envs/windows/README.md) | 11<br/>10 | scoop & winget | scoop for portal app, winget for installer app. |

# Run

**Ubuntu**

git clone repo and run ansible-playbook.

> [!NOTE]
> Docker will not be installed on WSL2 if Docker Dekstop integration is enabled.

```sh
mkdir -p ~/github/guitarrapc && cd ~/github/guitarrapc
git clone https://github.com/guitarrapc/local-provisioner
cd ~/github/guitarrapc/local-provisioner/envs/ubuntu
bash ./prerequisites.sh
bash ./run.sh
```

**macOS**

git clone repo and run ansible-playbook.

```sh
mkdir -p ~/github/guitarrapc && cd ~/github/guitarrapc
git clone https://github.com/guitarrapc/local-provisioner
cd ~/github/guitarrapc/local-provisioner/envs/macos
bash ./prerequisites.sh
exec $SHELL -l
bash ./run.sh
```

**Windows**

> [!NOTE] Enable Windows Developer mode beforehand.

Install git, git clone repo and run scoop-playbook.

```sh
winget list --accept-source-agreements
winget install -e --id Git.Git --accept-package-agreements
mkdir c:/github/guitarrapc
cd c:/github/guitarrapc
git clone https://github.com/guitarrapc/local-provisioner
cd c:/github/guitarrapc/local-provisioner/envs/windows
. ./prerequisites.ps1
. ./run.ps1
```

run exstra non-scoop tool installation.

```sh
cd c:/github/guitarrapc/local-provisioner/envs/windows/etc
. ./run.ps1
. ./install-winget-play.ps1 # for game playing environment
. ./install-wsl1.ps1
. ./install-wsl2.ps1
```

run extra configs.
```sh
cd c:/github/guitarrapc/local-provisioner/envs/windows/etc
. ./enable_longpath.reg
```

# Support status

**Ubuntu**

Role | Descriptions
---- | ----
credentials | link credentials on Windows. When it's WSL1 or WSL2.
debug | ansible status debugger.
docker | install docker.
dotfiles | link with [dofiles-linux](https://github.com/guitarrapc/dotfiles-linux)
needrestart | configure needrestart for WSL1 and WSL2. WSL1 will remove needrestart. WSL2 will disable apt package detection.
tools | miscellaneous tools setup.

Out of scopes

* None.

**macOS**

Role | Descriptions
---- | ----
defaults | macos defaults
dotfiles | link with [dofiles](https://github.com/guitarrapc/dotfiles)
homebrew | homebrew and cask packages
pam | pam module for touchid
ruby | ruby environment setup.
terraform | terraform environment setup. using tfenv.

Out of scopes

* Unity Editor (Use Unity Hub)

**Windows**

Scope for following.

Role | Descriptions
---- | ----
ba230t | install app via scoop's `ba230t` bucket
extras | install app via scoop's `extras` bucket
guitarrapc | install app via scoop's `guitarrapc` bucket
main | install app via scoop's `main` bucket
terraform-docs | install app via scoop's `terraform-docs` bucket

winget for following

* Docker for Windows
* Visual Studio or higher
* Unity Hub
* Steam
* other apps

# How to modify

Folk this repository.

**macOS**

* Modify parameters: `envs/macos/roles/<role>/vars/main.yml`.
* Modify logics: `envs/macos/roles/<role>/tasks/main.yml`.

**Ubuntu**

* Modify parameters: `envs/ubuntu/roles/<role>/vars/main.yml`.
* Modify logics: `envs/ubuntu/roles/<role>/tasks/main.yml`.
* Modify reuse logics: `envs/include_roleroles/ubuntu/<role>.yml`.

**Windows**

* Modify logics: `envs/windows/roles/<role>/tasks/main.yml`.

# Issues

* (Ubuntu) Ansible apt_key always show changed: https://github.com/ansible/ansible/issues/27798
* (Ubuntu) get_url is not controlable or too match differ from original context. Avoid using get_url and suppress warnings.
