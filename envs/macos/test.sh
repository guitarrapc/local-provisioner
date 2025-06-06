#!/bin/bash

# ansible spec
bundle install --path vendor/bundle

# create .ansiblespec
# bundle exec ansiblespec-init

bundle exec rake -T
bundle exec rake all
