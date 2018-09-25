require 'spec_helper'
set :backend, :exec

describe command("defaults read NSGlobalDomain com.apple.swipescrolldirection") do
    its(:stdout) { should match '0' }
end
