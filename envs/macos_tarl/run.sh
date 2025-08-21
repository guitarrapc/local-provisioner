#!/bin/bash
set -euo pipefail

# follow to the tartlet guide: https://github.com/shapehq/tartelet/wiki/Configuring-the-Virtual-Machine-to-Build-iOS-Apps

xcode_version=16.3
ruby_version=3.2.3
nodejs_version=22.16.4

function header {
    echo "=============================="
    echo "$1"
    echo "=============================="
}


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
if ! which brew; then
    echo Homebrew not found, install it.
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew doctor

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

# add runner user
header "Adding runner user"
if ! id "runner" &>/dev/null; then
    echo "Creating runner user..."

    # Find the next available UID (starting from 501)
    local_users=$(dscl . list /Users UniqueID | awk '{print $2}' | sort -n)
    next_uid=501
    for uid in $local_users; do
        if [ "$uid" -ge 501 ] && [ "$uid" -eq "$next_uid" ]; then
            next_uid=$((next_uid + 1))
        fi
    done

    # Create the user
    sudo dscl . create /Users/runner
    sudo dscl . create /Users/runner UserShell /bin/zsh
    sudo dscl . create /Users/runner RealName "Runner User"
    sudo dscl . create /Users/runner UniqueID $next_uid
    sudo dscl . create /Users/runner PrimaryGroupID 20
    sudo dscl . create /Users/runner NFSHomeDirectory /Users/runner

    # Set password
    echo "runner" | sudo dscl . passwd /Users/runner

    # Create home directory
    sudo createhomedir -c -u runner

    # Add to admin group for sudo access
    sudo dscl . append /Groups/admin GroupMembership runner

    echo "Runner user created successfully with UID $next_uid"
else
    echo "Runner user already exists, skipping creation"
fi

# Disable initial setup assistant
header "Disabling setup assistant"
sudo touch /var/db/.AppleSetupDone
sudo defaults write /Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
sudo defaults write /Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
sudo defaults write /Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion -string "$(sw_vers -productVersion)"

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

# auto login by runner
header "Configuring auto login for runner user"
current_autologin=$(sudo defaults read /Library/Preferences/com.apple.loginwindow autoLoginUser 2>/dev/null || echo "")
if [ "$current_autologin" != "runner" ]; then
    echo "Setting auto login user to runner..."

    # Enable auto login for runner user
    sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser -string "runner"

    # Create the auto login password file (macOS specific method)
    echo "runner" | sudo tee /etc/kcpassword > /dev/null
    sudo chmod 600 /etc/kcpassword

    # Disable screen saver and energy saver for continuous operation
    sudo defaults write /Library/Preferences/com.apple.screensaver loginWindowIdleTime -int 0
fi

# passwordless sudo
header "Configuring passwordless sudo"
if ! sudo grep -q "%admin.*ALL = (ALL) NOPASSWD: ALL" /etc/sudoers; then
    # Create a temporary sudoers file for editing
    TEMP_SUDOERS=$(mktemp)

    # Copy current sudoers and modify it
    sudo cp /etc/sudoers "$TEMP_SUDOERS"
    sudo sed -i '' 's/%admin[[:space:]]*ALL = (ALL) ALL/%admin          ALL = (ALL) NOPASSWD: ALL/' "$TEMP_SUDOERS"

    # Validate the modified sudoers file
    if sudo visudo -c -f "$TEMP_SUDOERS"; then
        echo "Sudoers file validation passed, applying changes..."
        sudo cp "$TEMP_SUDOERS" /etc/sudoers
        echo "Passwordless sudo configured successfully"
    else
        echo "ERROR: Invalid sudoers file, changes not applied"
        exit 1
    fi

    # Clean up temporary file
    sudo rm -f "$TEMP_SUDOERS"
fi

# Enable remote login (SSH)
header "Enabling remote login (SSH)"
if ! sudo systemsetup -getremotelogin | grep -q "On"; then
    sudo systemsetup -setremotelogin on
fi
