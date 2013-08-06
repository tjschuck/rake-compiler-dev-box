#!/usr/bin/env bash

set -e
source "$HOME/.rvm/scripts/rvm"

# shared directory between VM and host
cd '/vagrant'

# passed in path of gem to be cross-compiled
cd $1

# need to use 1.8.7 for fat-binaries (1.9.3 can't cross-build 1.8.7)
rvm use 1.8.7
gem install bundler && bundle install

bundle exec rake cross native gem RUBY_CC_VERSION=1.8.7:1.9.3:2.0.0
