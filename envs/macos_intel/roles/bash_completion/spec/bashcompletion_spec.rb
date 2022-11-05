require 'spec_helper'
set :backend, :exec

describe file('/usr/local/etc/bash_completion') do
    it { should be_linked_to '../Cellar/bash-completion/1.3_3/etc/bash_completion' }
end

describe file('/usr/local/etc/bash_completion.d/docker') do
    it { should be_linked_to '/Applications/Docker.app/Contents/Resources/etc/docker.bash-completion' }
end

describe file('/usr/local/etc/bash_completion.d/docker-machine') do
    it { should be_linked_to '/Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion' }
end

describe file('/usr/local/etc/bash_completion.d/docker-compose') do
    it { should be_linked_to '/Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion' }
end
