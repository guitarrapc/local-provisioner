#!/bin/bash
set -euo pipefail

# follow to the tartlet guide: https://github.com/shapehq/tartelet/wiki/Configuring-the-Virtual-Machine-to-Build-iOS-Apps

xcode_version=16.3
ruby_version=3.2.3
nodejs_version=22.18.0

function header {
    echo "=============================="
    echo "$1"
    echo "=============================="
}

# Disable macOS automatic update
header "Disabling macOS automatic updates"
# Disable automatic check for updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false
# Disable automatic download of updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool false
# Disable automatic installation of macOS updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false
# Disable automatic installation of app updates from App Store
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool false
# Disable system data files updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate SystemDataInstall -bool false
# Disable automatic installation of security updates and system files
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool false
# Disable Install Security Responses and system files
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate InstallSecurityResponsesAndSystemFiles -bool false

# run command only if current user is runner
header "check current user is runner"
if [ "$(whoami)" == "runner" ]; then
    echo "Running command as runner user..."
    # Place the command you want to run as the runner user here
else
    echo "Current user is not runner, skipping command."
fi

# brew
header "Installing brew"
sudo mkdir -p /opt/homebrew
if [[ "$(stat -f '%Su:%Sg' -L /opt/homebrew)" != "runner:admin" ]]; then
    sudo chown -R runner:admin /opt/homebrew
fi
if ! which brew; then
    echo Homebrew not found, install it.
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# disable brew
header "Configuring brew"
if [[ -f "$HOME/.zshrc" ]]; then
    touch "$HOME/.zshrc"
fi
if ! cat "$HOME/.zshrc" | grep "export HOMEBREW_NO_AUTO_UPDATE=1"; then
    echo "export HOMEBREW_NO_AUTO_UPDATE=1" | tee -a ~/.zshrc
fi
if ! cat "$HOME/.zshrc" | grep "export HOMEBREW_NO_INSTALL_CLEANUP=1"; then
    echo "export HOMEBREW_NO_INSTALL_CLEANUP=1" | tee -a ~/.zshrc
fi

# Install Xcode if image not has xcode
header "Installing Xcode"
if ! which xcode-select; then
  brew install xcodesorg/made/xcodes
  brew install aria2
  xcodes install $xcode_version
  xcodes select $xcode_version
  xcodes runtimes install "iOS 17.0"
else
  echo "Xcode already installed, skipping."
fi

# xcode tools
header "Installing Xcode tools"
brew install xcbeautify
brew install swiftlint

# commandline tool
header "Checking xcode command line tools"
if ! which xcrun; then
    echo apple commandline tools are not install. install latest.
    xcode-select --install
fi

# xcode simulators
xcodebuild -downloadPlatform iOS
xcrun simctl runtime install "iOS 18.4"

# fix python3 or any xcode tool issue
# see: prompt keeps popping up asking me to install the command line developer tools - https://developer.apple.com/forums/thread/704099?answerId=727578022#727578022
xcodebuild -runFirstLaunch

# asdf
header "Installing asdf"
brew install asdf
asdf plugin add ruby
asdf install ruby $ruby_version

asdf plugin add nodejs
asdf install nodejs $nodejs_version

header "Installing brew tools"
brew install jq
brew install git-lfs
brew install imagemagick

# ssh
header "Configuring git"
# Generate SSH key if it doesn't exist
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    echo "Generating SSH key..."
    ssh-keygen -t rsa -b 4096 -C "runner@shape.dk" -f "$HOME/.ssh/id_rsa" -N ""
fi
if ! grep "github.com" "$HOME/.ssh/known_hosts" 2>/dev/null; then
    echo "Adding GitHub to known_hosts..."
    ssh-keyscan -t rsa github.com | tee -a "$HOME/.ssh/known_hosts"
fi
git config --global user.name runner
git config --global user.name runner@shape.dk
ssh -T git@github.com -o ConnectTimeout=10 -o StrictHostKeyChecking=no || echo "SSH test completed (this may fail if key isn't added to GitHub yet)"

# certificate
header "Installing Apple WWDR certificate"
if [ ! -f "$HOME/Downloads/AppleWWDRCAG3.cer" ]; then
    curl -sSL -o "$HOME/Downloads/AppleWWDRCAG3.cer" https://www.apple.com/certificateauthority/AppleWWDRCAG3.cer
    sudo security import ~/Downloads/AppleWWDRCAG3.cer ~/Library/Keychain/login.keychain-db
fi
