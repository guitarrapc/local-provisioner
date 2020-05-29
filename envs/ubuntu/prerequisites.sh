#!/bin/bash

which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    sudo apt update & sudo apt upgrade -y
    sudo apt install -yqq daemonize dbus-user-session fontconfig

    # install ansible on python3
    sudo apt-get install -y python3-pip
    pip3 install --user ansible
fi
