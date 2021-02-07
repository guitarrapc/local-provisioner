require 'spec_helper'
set :backend, :exec

describe file('/Users/guitarrapc/.pyenv/plugins/pyenv-virtualenv') do
    it { should be_directory }
end

describe command("which pyenv") do
    its(:exit_status) { should eq 0 }
end

describe command("pyenv versions") do
    its(:stdout) { should match "3.8" }
end
