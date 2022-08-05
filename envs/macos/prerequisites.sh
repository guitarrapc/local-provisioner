#!/bin/bash

# commandline tool
echo "check xcode-select is installed"
xcrun -h > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo apple commandline tools are not install. install latest.
    xcode-select --install
fi

# brew
echo "check ansible is installed"
which brew > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Homebrew not found, install it.
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew doctor

# ansible
echo "check ansible is installed"
which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    brew install ansible
fi
