[![ansible lint](https://github.com/guitarrapc/local-provisioner/actions/workflows/ansible-lint.yaml/badge.svg)](https://github.com/guitarrapc/local-provisioner/actions/workflows/ansible-lint.yaml) [![install](https://github.com/guitarrapc/local-provisioner/actions/workflows/install.yaml/badge.svg)](https://github.com/guitarrapc/local-provisioner/actions/workflows/install.yaml)

# local-provisioner

Dev environment setup.

Environment | Version | Method | Note
---- | ---- | ---- | ----
[macOS](envs/macos/README.md) | Ventura<br/>Monterey | Ansible Playbook | Target to Apple Silicon and Intel.
[Ubuntu](envs/ubuntu/README.md) | 22.04<br/>20.04<br/>WSL1<br/>WSL2 | Ansible Playbook | install docker on wsl2.
[Windows](envs/windows/README.md) | 11<br/>10 | scoop |

# Run

**Ubuntu**

clone repo and run ansible-playbook.

```sh
mkdir -p ~/github/guitarrapc && cd ~/github/guitarrapc
git clone https://github.com/guitarrapc/local-provisioner
cd ~/github/guitarrapc/local-provisioner/envs/ubuntu
bash ./prerequisites.sh
bash ./run.sh
```

**macOS**

clone repo and run ansible-playbook.

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

Install git, then clone repo and run scoop-playbook.

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

# Test

**macOS**

```sh
cd envs/macos
# check tests
bundle exec rake -T
# run all tests (ansible_spec)
bundle exec rake all
```

**Linux**

No support.

**Windows**

No support.

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
ruby | ruby environment setup. using rbenv and just install bundler.
terraform | terraform environment setup. using tfenv.

Out of scopes

* Unity Editor (Use Unity Hub)

**Windows**

Role | Descriptions
---- | ----
ba230t | install app via scoop's `ba230t` bucket
extras | install app via scoop's `extras` bucket
guitarrapc | install app via scoop's `guitarrapc` bucket
main | install app via scoop's `main` bucket
terraform-docs | install app via scoop's `terraform-docs` bucket

Use winget to install non-scoop apps.

* Docker for Windows.
* Visual Studio or higher.
* Unity Hub
* Steam and others.

# How to modify

Folk this repository.

**macOS**

    * Modify parameters: `envs/macos/roles/<role>/vars/main.yml`.
    * Modify logics: `envs/macos/roles/<role>/tasks/main.yml`.

**Ubuntu**

    * Modify parameters: `envs/ubuntu/roles/<role>/vars/main.yml`.
    * Modify logics: `envs/ubuntu/roles/<role>/tasks/main.yml`.

**Windows**

    * Modify logics: `envs/windows/roles/<role>/tasks/main.yml`.

# Issues

* (Ubuntu) Ansible apt_key always show changed: https://github.com/ansible/ansible/issues/27798
* (Ubuntu) get_url is not controlable or too match differ from original context. Avoid using get_url and suppress warnings.
