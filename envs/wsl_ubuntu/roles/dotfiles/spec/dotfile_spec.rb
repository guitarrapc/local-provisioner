require 'spec_helper'
set :backend, :exec

describe file('/Users/guitarrapc/.ansible.cfg') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/macos/.ansible.cfg' }
end

describe file('/Users/guitarrapc/.bashrc') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/macos/.bashrc' }
end

describe file('/Users/guitarrapc/.bash_profile') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/macos/.bash_profile' }
end

describe file('/Users/guitarrapc/.gitconfig') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/macos/.gitconfig' }
end

describe file('/Users/guitarrapc/.gitignore_global') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/macos/.gitignore_global' }
end
