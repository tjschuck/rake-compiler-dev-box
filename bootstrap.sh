#!/usr/bin/env bash

set -e

as_vagrant='sudo -u vagrant -H bash -l -c'

apt-get -y update
apt-get install -y curl git-core mingw32 default-jdk

$as_vagrant 'echo "gem: --no-ri --no-rdoc" >> ~/.gemrc'

# install rvm

$as_vagrant 'curl -L https://get.rvm.io | bash -s stable'

$as_vagrant '~/.rvm/bin/rvm install jruby'
$as_vagrant '~/.rvm/bin/rvm install 1.9.3'
$as_vagrant '~/.rvm/bin/rvm install 1.8.7'
