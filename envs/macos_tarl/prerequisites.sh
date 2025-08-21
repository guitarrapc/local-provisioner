#!/bin/bash
set -euo pipefail

# follow the tartlet guide: https://github.com/shapehq/tartelet/wiki/Configuring-Tartelet

function header {
    echo "=============================="
    echo "$1"
    echo "=============================="
}

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
    sudo sysadminctl -addUser runner -fullName "Runner" -home /Users/runner -shell /bin/zsh -admin -password "runner"
    if [ -L /Users/runner ]; then
      sudo rm /Users/runner
    fi
    sudo createhomedir -c -u runner >/dev/null 2>&1 || true
    sudo chown -R runner:staff /Users/runner

    # Add to admin group for sudo access
    sudo dscl . append /Groups/admin GroupMembership runner


    echo "Runner user created successfully with UID $next_uid"
else
    echo "Runner user already exists, skipping creation"
fi

header "Allow /opt/homebrew for runner user"
if [ ! -d /opt/homebrew ]; then
    sudo mkdir -p /opt/homebrew
    sudo chgrp -R admin /opt/homebrew
    sudo chmod -R g+w /opt/homebrew
    sudo find /opt/homebrew -type d -exec chmod g+ws {} \;
    sudo -u runner mkdir -p /Users/runner/Library/Caches/Homebrew
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
