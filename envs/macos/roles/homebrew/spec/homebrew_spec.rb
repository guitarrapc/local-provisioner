require 'spec_helper'
set :backend, :exec

describe command("brew list -l") do
    its(:stdout) { should match "ansible" }
    its(:stdout) { should match "autoconf" }
    its(:stdout) { should match "awscli" }
    its(:stdout) { should match "aws-iam-authenticator" }
    its(:stdout) { should match "azure-cli" }
    its(:stdout) { should match "bash-completion" }
    its(:stdout) { should match "bat" }
    its(:stdout) { should match "brew-cask-completion" }
    its(:stdout) { should match "carthage" }
    its(:stdout) { should match "circleci" }
    its(:stdout) { should match "direnv" }
    its(:stdout) { should match "docker" }
    its(:stdout) { should match "freetype" }
    its(:stdout) { should match "gibo" }
    its(:stdout) { should match "git-lfs" }
    its(:stdout) { should match "go" }
    its(:stdout) { should match "hub" }
    its(:stdout) { should match "hugo" }
    its(:stdout) { should match "kubectx" }
    its(:stdout) { should match "kubernetes-helm" }
    its(:stdout) { should match "mackerel-agent" }
    its(:stdout) { should match "nodebrew" }
    its(:stdout) { should match "pyenv" }
    its(:stdout) { should match "rbenv" }
    its(:stdout) { should match "ruby-build" }
    its(:stdout) { should match "stern" }
    its(:stdout) { should match "swiftlint" }
    its(:stdout) { should match "tfenv" }
    its(:stdout) { should match "tree" }
    its(:stdout) { should match "yarn" }
    its(:stdout) { should match "yq" }
    its(:stdout) { should match "zlib" }
end

