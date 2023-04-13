[![ansible lint](https://github.com/guitarrapc/local-provisioner/actions/workflows/ansible-lint.yaml/badge.svg)](https://github.com/guitarrapc/local-provisioner/actions/workflows/ansible-lint.yaml)

# local-provisioner

Dev environment setup.

Environment | Version | Method | Note
---- | ---- | ---- | ----
macOS | Intel Monterey | Ansible Playbook |
macOS-silicon | Ventura<br/>Monterey | Ansible Playbook |
Windows | 11 22H2<br/>11 21H2<br/>10 21H2 | scoop |
Ubuntu | 22.04<br/>20.04<br/>WSL1<br/>WSL2 | Ansible Playbook | install docker on wsl2.

## Run

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

![image](https://user-images.githubusercontent.com/3856350/67872931-0465bd80-fb76-11e9-8700-bdc0e861f556.png)

**macOS Silicon**

run ansible-playbook.

```shell
cd ~/github/guitarrapc/local-provisioner/envs/macos
bash ./prerequisites.sh
exec $SHELL -l
bash ./run.sh
```

**macOS Intel**

run ansible-playbook.

```shell
cd ~/github/guitarrapc/local-provisioner/envs/macos_intel
bash ./prerequisites.sh
exec $SHELL -l
bash ./run.sh
```

![image](https://user-images.githubusercontent.com/3856350/67872838-dda78700-fb75-11e9-9073-a4cc0f37e6d1.png)

**Windows 10/11**

run scoop-playbook.

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

Role | Descriptions
---- | ----
credentials | link credentials on Windows. When it's WSL1 or WSL2.
debug | ansible status debugger.
docker | install docker.
dotfiles | link with [dofiles-linux](https://github.com/guitarrapc/dotfiles-linux)
needrestart | configure needrestart for WSL1 and WSL2. WSL1 will remove needrestart. WSL2 will disable apt package detection.
tools | miscellaneous tools setup.

### macOS

Role | Descriptions
---- | ----
defaults | macos defaults
dotfiles | link with [dofiles](https://github.com/guitarrapc/dotfiles)
homebrew | homebrew packages
homebrew_cask | homebrew packages for GUI App
pam | pam module for touchid
ruby | ruby environment setup. using rbenv and just install bundler.
terraform | terraform environment setup. using tfenv.

* Each Unity Editor (Use Unity Hub)

### Windows

Role | Descriptions
---- | ----
dotfiles | NOT YET. link with [dofiles-win](https://github.com/guitarrapc/dotfiles-win)
ba230t | install app via scoop's `ba230t` bucket
extras | install app via scoop's `extras` bucket
guitarrapc | install app via scoop's `guitarrapc` bucket
main | install app via scoop's `main` bucket

Out of scopes

* Docker for Windows.
* Visual Studio 20xx or higher.
* .NET Core SDK
* Each Unity Editor (Use Unity Hub)

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
