[![ansible lint](https://github.com/guitarrapc/local-provisioner/actions/workflows/ansible-lint.yaml/badge.svg)](https://github.com/guitarrapc/local-provisioner/actions/workflows/ansible-lint.yaml) [![install](https://github.com/guitarrapc/local-provisioner/actions/workflows/install.yaml/badge.svg)](https://github.com/guitarrapc/local-provisioner/actions/workflows/install.yaml)

# local-provisioner

Dev environment setup.

Environment | Version | Method | Note
---- | ---- | ---- | ----
macOS | Ventura<br/>Monterey | Ansible Playbook | Target to Apple Silicon and Intel.
Ubuntu | 22.04<br/>20.04<br/>WSL1<br/>WSL2 | Ansible Playbook | install docker on wsl2.
Windows | 11<br/>10 | scoop |

# Run

clone repo setup.

```shell
mkdir -p ~/github/guitarrapc && cd ~/github/guitarrapc
git clone https://github.com/guitarrapc/local-provisioner
```

**Ubuntu**

run ansible-playbook.

```shell
cd ~/github/guitarrapc/local-provisioner/envs/ubuntu
bash ./prerequisites.sh
bash ./run.sh
```

**macOS**

run ansible-playbook.

```shell
cd ~/github/guitarrapc/local-provisioner/envs/macos
bash ./prerequisites.sh
exec $SHELL -l
bash ./run.sh
```

**Windows**

run scoop-playbook.

```shell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
cd ~/github/guitarrapc/local-provisioner/envs/windows
. ./prerequisites.ps1
. ./run.ps1
```

# Test

**macOS**

```shell
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

Out of scopes

* Docker for Windows.
* Visual Studio or higher.
* .NET SDK
* Unity Editor (Use Unity Hub)

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
