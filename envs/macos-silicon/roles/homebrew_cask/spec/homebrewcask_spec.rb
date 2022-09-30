require 'spec_helper'
set :backend, :exec

describe command("brew cask list -1") do
    its(:stdout) { should match "android-studio" }
    its(:stdout) { should match "aws-vault" }
    its(:stdout) { should match "cd-to" }
    its(:stdout) { should match "docker" }
    its(:stdout) { should match "dotnet-sdk" }
    its(:stdout) { should match "google-chrome" }
    its(:stdout) { should match "gitkraken" }
    its(:stdout) { should match "kindle" }
    its(:stdout) { should match "krisp" }
    # its(:stdout) { should match "powershell" }
    its(:stdout) { should match "slack" }
    its(:stdout) { should match "unity-hub" }
    its(:stdout) { should match "visual-studio-code" }
    its(:stdout) { should match "zoomus" }
end
