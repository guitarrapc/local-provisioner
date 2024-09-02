#!/bin/bash
set -eu -o pipefail

required_python3_version="3.13"
required_ansible_version="2.17.3"

# update apt
sudo apt update -y
sudo apt autoremove -y

function hack:wsl1_ubuntu20 {
    if lshw | grep vsyscall32; then
      is_wsl2=1
    else
      is_wsl2=0
    fi
    is_ubuntu2004=$(lsb_release -r | grep -c "20.04")
    if [[ "${is_wsl2}" == "0" && "${is_ubuntu2004}" == "1" ]]; then
      # sleep cannot use in WSL1 Ansible hack
      echo "detected Ubuntu 20.04 on WSL1, applying sleep hack. https://stackoverflow.com/questions/62363901/ansible-msg-failed-to-create-temporary-directory-in-some-cases-fatal"
      if [[ ! -L "/bin/sleep" ]]; then
        sudo mv /bin/sleep /bin/sleep~
        sudo ln -s /bin/busybox /bin/sleep
      else
        echo "sleep symlink already exists."
      fi
    fi
}

function install_python3 {
  echo "Install Python ${required_python3_version}"
  sudo apt install -y software-properties-common
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt update -y
  sudo apt -y install "python${required_python3_version}" "python3-pip"
}

function install_ansible {
  # Install Ansible from ppa for latest release and fast update.
  # `pip3 install --user ansible` is too slow and could not accept.
  echo "Install ansible from ppa."
  if ! ls /etc/apt/sources.list.d/ansible-*-ansible*.list > /dev/null 2>&1; then
    sudo add-apt-repository -y --update ppa:ansible/ansible
  fi
  sudo apt update -y
  sudo apt install -y ansible

  # install ansible-lint
  pip3 install --user ansible-lint
}

echo "# Checking pip3 installed."
if ! command -v "python${required_python3_version}" > /dev/null 2>&1; then
  echo "python${required_python3_version} not found, install it."
  install_python3
else
  echo "python${required_python3_version} found."
fi

echo "# Checking ansible installed."
if ! command -v ansible > /dev/null 2>&1 || ! ansible --version | grep "${required_ansible_version}" > /dev/null 2>&1; then
  echo "Ansible not found, install it."
  install_ansible

  # target = Ubuntu20.04LTS on WSL1
  hack:wsl1_ubuntu20
else
  echo "Ansible ${required_ansible_version} found."
fi
