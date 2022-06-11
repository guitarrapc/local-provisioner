#!/bin/bash

set -ex

function hack:wsl1_ubuntu20() {
    is_wsl2=$([ $(grep -oE 'gcc version ([0-9]+)' /proc/version | awk '{print $3}') -gt 5 ] && echo "1" || echo "0")
    is_ubuntu2004=$(lsb_release -r | grep 20.04 | wc -l)
    if [[ "$is_wsl2" == "0" && "$is_ubuntu2004" == "1" ]]; then
      # sleep cannot use in WSL1 Ansible hack
      echo "detected Ubuntu 20.04 on WSL1, applying sleep hack. https://stackoverflow.com/questions/62363901/ansible-msg-failed-to-create-temporary-directory-in-some-cases-fatal"
      sudo mv /bin/sleep /bin/sleep~
      sudo ln -s /bin/busybox /bin/sleep
    fi
}

function install_ansible_before_ubuntu22() {
  if ! lsb_release -r | grep -V 22.04; then
    # install ansible on python3
    echo "Install ansible from pip3."
    sudo apt install -y python3-pip
    pip3 install --user ansible
  fi
}

function install_ansible_ubuntu22() {
  if lsb_release -r | grep 22.04; then
    # Install Ansible from ppa for latest release and fast update.
    echo "Install ansible from ppa."
    sudo apt install -y software-properties-common
    sudo add-apt-repository -y --update ppa:ansible/ansible
    sudo apt install -y ansible
  fi
}

if ! which ansible; then
    echo Ansible not found, install it.
    sudo apt update -y
    sudo apt upgrade -y

    # install ansible
    install_ansible_before_ubuntu22
    install_ansible_ubuntu22

    # Ubuntu20.04LTS on WSL1
    hack:wsl1_ubuntu20
fi
