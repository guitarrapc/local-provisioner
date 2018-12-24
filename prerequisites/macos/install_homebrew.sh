#!/bin/bash

which brew > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo Homebrew not found, install it.
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    brew update
    #brew upgrade --all
    brew doctor
fi