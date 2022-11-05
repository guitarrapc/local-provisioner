require 'spec_helper'
set :backend, :exec

describe command("brew cask list -1") do
    its(:stdout) { should match "font-dejavu-sans" }
end

describe file('/Users/guitarrapc/Library/Fonts/DejaVuSansMono.ttf') do
    it { should be_file }
end