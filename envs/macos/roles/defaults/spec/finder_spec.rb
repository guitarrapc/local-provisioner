require 'spec_helper'
set :backend, :exec

describe command("defaults read NSGlobalDomain AppleShowAllExtensions") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.finder FinderSounds") do
    its(:stdout) { should match '0' }
end

describe command("defaults read com.apple.finder ShowTabView") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.finder ShowPathbar") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.finder _FXSortFoldersFirst") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.finder FXDefaultSearchScope") do
    its(:stdout) { should match 'SCcf' }
end

describe command("defaults read com.apple.finder FXEnableExtensionChangeWarning") do
    its(:stdout) { should match '0' }
end

describe command("defaults read com.apple.desktopservices DSDontWriteNetworkStores") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.desktopservices DSDontWriteUSBStores") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.finder FXPreferredViewStyle") do
    its(:stdout) { should match 'Nlsv' }
end
