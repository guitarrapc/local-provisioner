#!/bin/bash

which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    sudo apt update
    sudo apt install snapd
    sudo snap install hello-world
    hello-world
fi
