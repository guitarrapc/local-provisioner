require 'spec_helper'
set :backend, :exec

describe command("which rbenv") do
    its(:exit_status) { should eq 0 }
end

describe command("rbenv versions") do
    its(:stdout) { should match "2.5.1" }
end

describe command("gem list --local") do
    its(:stdout) { should match "bundler" }
end

