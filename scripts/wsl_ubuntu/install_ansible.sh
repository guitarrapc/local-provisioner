#!/bin/bash

which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    sudo apt-get update
    sudo apt-get install ansible
fi