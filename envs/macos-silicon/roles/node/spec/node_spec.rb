require 'spec_helper'
set :backend, :exec

describe file('/Users/guitarrapc/.nodebrew/src') do
    it { should be_directory }
end

describe command("which node") do
    its(:exit_status) { should eq 0 }
end

describe command("nodebrew ls") do
    its(:stdout) { should match "v8.12.0" }
end

describe command("npm list -g --depth=0") do
    its(:stdout) { should match "firebase-tools" }
    its(:stdout) { should match "typescript" }
end

