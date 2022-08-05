require 'spec_helper'
set :backend, :exec

describe command("brew list -l") do
    its(:stdout) { should match "ansible" }
    its(:stdout) { should match "autoconf" }
    its(:stdout) { should match "awscli" }
    its(:stdout) { should match "bash-completion" }
    its(:stdout) { should match "bat" }
    its(:stdout) { should match "carthage" }
    its(:stdout) { should match "ctop" }
    its(:stdout) { should match "direnv" }
    its(:stdout) { should match "docker" }
    its(:stdout) { should match "freetype" }
    its(:stdout) { should match "gibo" }
    its(:stdout) { should match "git" }
    its(:stdout) { should match "git-lfs" }
    its(:stdout) { should match "go" }
    its(:stdout) { should match "hub" }
    its(:stdout) { should match "hugo" }
    its(:stdout) { should match "java" }
    its(:stdout) { should match "jq" }
    its(:stdout) { should match "kubectl" }
    its(:stdout) { should match "nodeenv" }
    its(:stdout) { should match "pyenv" }
    its(:stdout) { should match "rbenv" }
    its(:stdout) { should match "ruby-build" }
    its(:stdout) { should match "stern" }
    its(:stdout) { should match "tfenv" }
    its(:stdout) { should match "tree" }
    its(:stdout) { should match "yarn" }
    its(:stdout) { should match "yq" }
    its(:stdout) { should match "zlib" }
end
