#!/bin/bash

function hack:wsl1_ubuntu20() {
    is_wsl1=$(cat /proc/version | grep Microsoft | wc -l)
    is_ubuntu2004=$(lsb_release -r | grep 20.04 | wc -l)
    if [[ "$is_wsl1" == "1" && "$is_ubuntu2004" == 1 ]]; then
      echo "detected Ubuntu 20.04 on WSL1, applying sleep hack. https://stackoverflow.com/questions/62363901/ansible-msg-failed-to-create-temporary-directory-in-some-cases-fatal"
      sudo mv /bin/sleep /bin/sleep~
      sudo ln -s /bin/busybox /bin/sleep
    fi
}

which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    sudo apt update & sudo apt upgrade -y
    sudo apt install -yqq daemonize dbus-user-session fontconfig

    # install ansible on python3
    sudo apt-get install -y python3-pip
    pip3 install --user ansible

    # Ubuntu20.04LTS on WSL1
    hack:wsl1_ubuntu20()
fi
