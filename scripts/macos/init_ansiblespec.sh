#!/bin/bash
# run at repository root
bundle install --path vendor/bundle
cd playbooks/macos
bundle exec ansiblespec-init
