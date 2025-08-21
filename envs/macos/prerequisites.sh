#!/bin/bash

# commandline tool
echo "check xcode-select is installed"
xcrun -h > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo apple commandline tools are not install. install latest.
    xcode-select --install
fi

# fix python3 or any xcode tool issue
# see: prompt keeps popping up asking me to install the command line developer tools - https://developer.apple.com/forums/thread/704099?answerId=727578022#727578022
xcodebuild -runFirstLaunch

# brew
echo "check ansible is installed"
which brew > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Homebrew not found, install it.
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew update
brew doctor

# ansible
echo "check ansible is installed"
if ! which ansible; then
    echo Ansible not found, install it.
    brew install ansible
fi
brew upgrade ansible

if ! which ansible-lint; then
    echo Ansible Lint not found, install it.
    brew install ansible-lint
fi
brew upgrade ansible-lint
