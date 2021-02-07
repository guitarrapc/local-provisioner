require 'spec_helper'
set :backend, :exec

describe command("defaults read com.apple.dock minimize-to-application") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.dock show-process-indicators") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.dock autohide") do
    its(:stdout) { should match '0' }
end

# describe command("defaults read com.apple.dock wvous-bl-corner") do
#     its(:stdout) { should match '5' }
# end

# describe command("defaults read com.apple.dock wvous-bl-modifier") do
#     its(:stdout) { should match '0' }
# end
