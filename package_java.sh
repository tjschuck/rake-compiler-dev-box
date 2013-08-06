#!/usr/bin/env bash

set -e
source "$HOME/.rvm/scripts/rvm"

# shared directory between VM and host
cd '/vagrant'

# passed in path of gem to be cross-compiled
cd $1

# ensure JRuby uses RubyGems 1.8.x installed (as rake-compiler requires it)
rvm use jruby
gem update --system 1.8.25

gem install bundler && bundle install

bundle exec rake java gem
