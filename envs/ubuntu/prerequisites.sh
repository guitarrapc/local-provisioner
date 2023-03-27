#!/bin/bash -ex

function hack:wsl1_ubuntu20() {
    if lshw | grep vsyscall32; then
      is_wsl2=1
    else
      is_wsl2=0
    fi
    is_ubuntu2004=$(lsb_release -r | grep -c "20.04")
    if [[ "${is_wsl2}" == "0" && "${is_ubuntu2004}" == "1" ]]; then
      # sleep cannot use in WSL1 Ansible hack
      echo "detected Ubuntu 20.04 on WSL1, applying sleep hack. https://stackoverflow.com/questions/62363901/ansible-msg-failed-to-create-temporary-directory-in-some-cases-fatal"
      sudo mv /bin/sleep /bin/sleep~
      sudo ln -s /bin/busybox /bin/sleep
    fi
}

function install_ansible() {
  echo "Install Python 3.9"
  sudo apt install -y software-properties-common
  sudo add-apt-repository ppa:deadsnakes/ppa
  sudo apt update
  sudo apt -y install python3.9

  # Install Ansible from ppa for latest release and fast update.
  # `pip3 install --user ansible` is too slow and could not accept.
  echo "Install ansible from ppa."
  sudo add-apt-repository -y --update ppa:ansible/ansible
  sudo apt install -y ansible
  # install ansible-lint
  pip3 install --user ansible-lint
}

if ! which ansible; then
    echo Ansible not found, install it.
    sudo apt update -y
    sudo apt upgrade -y

    # install ansible
    install_ansible

    # Ubuntu20.04LTS on WSL1
    hack:wsl1_ubuntu20
fi
