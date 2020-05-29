# local-provisioner

Dev environment setup.

Status | Environment | Method
---- | ---- | ----
done | macOS (Mojave, High Sierra) | Ansible Playbook
done | Windows 10 | scoop
done | Ubuntu : Bash on Windows Subsystem for Linux (WSL) | Ansible Playbook

## How to Run

setup.

```shell
mkdir -p ~/github/guitarapc
cd ~/github/guitarapc
git clone https://github.com/guitarrapc/local-provisioner
cd local-provisioner
```

### Run

> make sure you have installed ansible. it can be accomplished via prerequisites.

macOS, run ansible-playbook.

```shell
cd envs/macos
. ./prerequisites.sh
ansible-playbook -i hosts site.yml
```

![image](https://user-images.githubusercontent.com/3856350/67872838-dda78700-fb75-11e9-9073-a4cc0f37e6d1.png)

Windows 2004 and higher, run scoop-playbook.

```shell
cd envs/windows
. ./prerequisites.ps1
scoop-playbook
```

![image](https://user-images.githubusercontent.com/3856350/67872580-84d7ee80-fb75-11e9-8c1c-e7d25fc94892.png)

Ubuntu, Bash on WSL2, run ansible-playbook.

```shell
cd envs/ubuntu
. ./prerequisites.sh
ansible-playbook -i hosts site.yml --ask-become-pass
```

![image](https://user-images.githubusercontent.com/3856350/67872931-0465bd80-fb76-11e9-8700-bdc0e861f556.png)

## How to modify

Folk this repository.

macOS will change by modify followings.

* Modify parameters by open `envs/macos/roles/<role>/vars/main.yml`.
* Modify logic by open `envs/macos/roles/<role>/tasks/main.yml`.

Windows will change by modify followings.

* Modify parameters by open `envs/windows/roles/<role>/tasks/main.yml`.

macOS / Ubuntu will change by modify followings.

* Modify parameters by open `envs/wsl_ubuntu/roles/<role>/vars/main.yml`.
* Modify logic by open `envs/wsl_ubuntu/roles/<role>/tasks/main.yml`.

## Out of scope

Windows will not handle followings.

* Docker for Windows.
* Google Chrome
* Visual Studio 2017 or higher.

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
