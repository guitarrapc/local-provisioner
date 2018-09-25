require 'spec_helper'
set :backend, :exec

describe command("which tfenv") do
    its(:exit_status) { should eq 0 }
end

describe command("tfenv list") do
    its(:stdout) { should match "0.11.8" }
end
