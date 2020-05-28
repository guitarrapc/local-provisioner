#!/bin/bash

which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    sudo apt update & sudo apt upgrade -y
    sudo apt install -yqq daemonize dbus-user-session fontconfig

    # install ansible on python3
    sudo apt-get install -y python3-pip
    pip3 install --user ansible

    # prepare snap
    sudo apt install -y snapd
    sudo cp ./sbin/start-systemd-namespace /usr/sbin/start-systemd-namespace & sudo chmod +x /usr/sbin/start-systemd-namespace
    sudo cp ./sbin/enter-systemd-namespace /usr/sbin/enter-systemd-namespace & sudo chmod +x /usr/sbin/enter-systemd-namespace
    sudo sed -i 2a"# Start or enter a PID namespace in WSL2\nsource /usr/sbin/start-systemd-namespace\n" /etc/bash.bashrc
fi

echo "installing ansible & snap complete."
echo "log out and try "
echo "$ sudo snap install hello-world"
echo "$ hello-world"
