#!/bin/bash
set -eu -o pipefail

required_python3_version="3.11"

function update_apt {
  sudo apt update -y
  sudo apt autoremove -y
}

function print_title {
  echo ""
  echo "#############################################"
  echo "# $1"
  echo "#############################################"
}

function hack:wsl1_ubuntu20 {
  # target = Ubuntu20.04LTS on WSL1
  if lshw | grep vsyscall32 > /dev/null 2>&1; then
    is_wsl2=1
  fi
  if lsb_release -r | grep -c "20.04" > /dev/null 2>&1; then
    is_ubuntu2004=1
  fi
  if [[ "${is_wsl2:-0}" == "0" && "${is_ubuntu2004:-0}" == "1" ]]; then
    # sleep cannot use in WSL1 Ansible hack
    echo "detected Ubuntu 20.04 on WSL1, applying sleep hack. https://stackoverflow.com/questions/62363901/ansible-msg-failed-to-create-temporary-directory-in-some-cases-fatal"
    if [[ ! -L "/bin/sleep" ]]; then
      sudo mv /bin/sleep /bin/sleep~
      sudo ln -s /bin/busybox /bin/sleep
    else
      echo "sleep symlink already exists."
    fi
  else
    echo "No need to apply sleep hack."
  fi
}

function install_python3 {
  echo "Install Python ${required_python3_version}"
  sudo apt install -y software-properties-common
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt update -y
  sudo apt -y install "python${required_python3_version}" "python3-pip" "pipx"
  pipx ensurepath
}

function install_ansible {
  # Install Ansible from ppa for latest release and fast update.
  # `pipx install --user ansible` is too slow and could not accept.
  echo "Install ansible from ppa."
  if ! ls /etc/apt/sources.list.d/ansible-*-ansible*.list > /dev/null 2>&1; then
    sudo add-apt-repository -y --update ppa:ansible/ansible
  fi
  sudo apt update -y
  sudo apt install -y ansible
}

function show_tool_versions {
  python3 --version
  ansible --version
}

print_title "Updating apt."
update_apt

print_title "Installing python and tools."
install_python3

print_title "Installing Ansible."
install_ansible

print_title "Checking and hack for WSL1 Ubuntu 20.04"
hack:wsl1_ubuntu20

print_title "Show tool versions."
show_tool_versions
