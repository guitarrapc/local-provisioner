require 'spec_helper'
set :backend, :exec

describe command("defaults read com.apple.screensaver askForPassword") do
    its(:stdout) { should match '1' }
end

describe command("defaults read com.apple.screensaver askForPasswordDelay") do
    its(:stdout) { should match '0' }
end

describe command("defaults read 'com.apple.screencapture' disable-shadow") do
    its(:stdout) { should match '1' }
end
