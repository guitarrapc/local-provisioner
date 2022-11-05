require 'spec_helper'
set :backend, :exec

describe file('/Users/guitarrapc/.ansible.cfg') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.ansible.cfg' }
end

describe file('/Users/guitarrapc/.bash_profile') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.bash_profile' }
end

describe file('/Users/guitarrapc/.bashrc') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.bashrc' }
end

describe file('/Users/guitarrapc/.bashrc.alias') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.bashrc.alias' }
end

describe file('/Users/guitarrapc/.bashrc.custom') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.bashrc.custom' }
end

describe file('/Users/guitarrapc/.csslintrc') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.csslintrc' }
end

describe file('/Users/guitarrapc/.gitattributes') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.gitattributes' }
end

describe file('/Users/guitarrapc/.gitconfig') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.gitconfig' }
end

describe file('/Users/guitarrapc/.gitignore_global') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.gitignore_global' }
end

describe file('/Users/guitarrapc/.gitprompt.sh') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.gitprompt.sh' }
end

describe file('/Users/guitarrapc/.stCommitMsg') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/.stCommitMsg' }
end


describe file('/Users/guitarrapc/.ssh/config') do
    it { should be_linked_to '/Users/guitarrapc/github/guitarrapc/dotfiles/home/.ssh/config' }
end
