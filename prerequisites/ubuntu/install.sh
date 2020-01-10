#!/bin/bash

which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    sudo apt-get update
    sudo apt-get install -y python3-pip
    pip3 install --user ansible
fi
