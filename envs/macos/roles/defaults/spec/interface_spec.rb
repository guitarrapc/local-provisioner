require 'spec_helper'
set :backend, :exec

describe command("defaults read NSGlobalDomain AppleInterfaceStyle") do
    its(:stdout) { should match 'Dark' }
end

describe command("defaults read 'Apple Global Domain' AppleInterfaceStyle") do
    its(:stdout) { should match 'Dark' }
end
