#!/usr/bin/env bash

set -e
source "$HOME/.rvm/scripts/rvm"

# shared directory between VM and host
cd '/vagrant'

# passed in path of gem to be cross-compiled
cd $1

rvm use 1.9.3
gem install bundler && bundle install
bundle exec rake native gem
