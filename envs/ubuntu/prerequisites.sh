#!/bin/bash

which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    sudo apt update & sudo apt upgrade -y
    sudo apt install -yqq daemonize dbus-user-session fontconfig

    sudo cp ./sbin/start-systemd-namespace /usr/sbin/start-systemd-namespace & sudo chmod +x /usr/sbin/start-systemd-namespace
    sudo cp ./sbin/enter-systemd-namespace /usr/sbin/enter-systemd-namespace & sudo chmod +x /usr/sbin/enter-systemd-namespace
    sudo sed -i 2a"# Start or enter a PID namespace in WSL2\nsource /usr/sbin/start-systemd-namespace\n" /etc/bash.bashrc

    sudo apt install -y snapd
    sudo snap install hello-world
    hello-world
fi
