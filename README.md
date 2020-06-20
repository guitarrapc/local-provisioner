# local-provisioner

Dev environment setup.

Environment | Version | Method
---- | ---- | ----
macOS | Mojave | Ansible Playbook
Windows | 10 2020 May Update| scoop
Ubuntu | 18.04<br/>WSL1<br/>WSL2 | Ansible Playbook

## Run

clone repo setup.

```shell
mkdir -p ~/github/guitarapc
cd ~/github/guitarapc
git clone https://github.com/guitarrapc/local-provisioner
cd local-provisioner
```

Ubuntu, Bash on WSL2, run ansible-playbook.

```shell
cd envs/ubuntu
. ./prerequisites.sh
. ./run.sh
```

![image](https://user-images.githubusercontent.com/3856350/67872931-0465bd80-fb76-11e9-8700-bdc0e861f556.png)

macOS, run ansible-playbook.

```shell
cd envs/macos
. ./prerequisites.sh
. ./run.sh
```

![image](https://user-images.githubusercontent.com/3856350/67872838-dda78700-fb75-11e9-9073-a4cc0f37e6d1.png)

Windows 10, run scoop-playbook.

```shell
cd envs/windows
. ./prerequisites.ps1
scoop-playbook
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

include WSL and WSL2

Role | Descriptions
---- | ----
awscli | awscli setup.
azcli | azure cli setup.
bombardier | simple web benchmark tool.
circleci | circleci cli.
debug | ansible status debugger.
docker | docker installation when it's not WSL2.
dotfiles | link with [dofiles-linux](https://github.com/guitarrapc/dofiles-linux)
dotnetsdk | install .NET Core SDK.
envsubst2 | install envsubst for ubuntu.
kubernets | install kubernetes related.
ngrok | install ngrok.
pulumi | install pulumi cli.
terraform | terraform environment setup. using tfenv.
tools | miscellaneous tools setup.
yq | install yq.

### macOS

Role | Descriptions
---- | ----
bash_completion | bash completion symlinks
defaults | macos defaults
dotfiles | dotfiles
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
[dotfiles] | **NOT YET**
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
