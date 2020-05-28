#!/bin/bash

# commandline tool
xcrun -h > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo apple commandline tools are not install. install latest.
    xcode-select --install
fi

# brew 
which brew > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Homebrew not found, install it.
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    brew update
    #brew upgrade --all
    brew doctor
fi

brew tap caskroom/cask
brew tap caskroom/fonts

# ansible
which ansible > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Ansible not found, install it.
    brew install ansible
fi

# ansible spec
cd ../..
bundle install --path vendor/bundle
cd playbooks/macos
bundle exec ansiblespec-init
