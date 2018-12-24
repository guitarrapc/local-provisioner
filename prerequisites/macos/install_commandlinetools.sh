#!/bin/bash

xcrun -h > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo apple commandline tools are not install. install latest.
    xcode-select --install
fi