#!/usr/bin/env bash

set -e

as_vagrant='sudo -u vagrant -H bash -l -c'
home='/home/vagrant'
touch $home/.bash_profile

# Use all available CPU cores for compiling
if [[ $(nproc) -gt 1 ]] && ! grep -q "make -j" $home/.bash_profile; then
  echo 'export MAKE="make -j$(nproc)"' >> $home/.bash_profile
  source $home/.bash_profile
fi

apt-get -y update
apt-get install -y curl git-core mingw-w64 default-jdk unzip

# Install wrappers for strip commands
if [ ! -f "/usr/bin/i686-w64-mingw32-strip.bin" ]; then
  echo "Install wrapper for i686-w64-mingw32-strip"
  mv /usr/bin/i686-w64-mingw32-strip /usr/bin/i686-w64-mingw32-strip.bin
  cp /vagrant/bin/strip_wrapper /usr/bin/i686-w64-mingw32-strip
fi

if [ ! -f "/usr/bin/x86_64-w64-mingw32-strip.bin" ]; then
  echo "Install wrapper for x86_64-w64-mingw32-strip"
  mv /usr/bin/x86_64-w64-mingw32-strip /usr/bin/x86_64-w64-mingw32-strip.bin
  cp /vagrant/bin/strip_wrapper /usr/bin/x86_64-w64-mingw32-strip
fi

if [ ! -f "/usr/bin/i586-mingw32msvc-strip.bin" ]; then
  echo "Install wrapper for i586-mingw32msvc-strip"
  mv /usr/bin/i586-mingw32msvc-strip /usr/bin/i586-mingw32msvc-strip.bin
  cp /vagrant/bin/strip_wrapper /usr/bin/i586-mingw32msvc-strip
fi

# do not generate documentation for gems
$as_vagrant 'echo "gem: --no-ri --no-rdoc" >> ~/.gemrc'

# install rvm
$as_vagrant 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'
$as_vagrant 'curl -L https://get.rvm.io | bash'

# source rvm for usage outside of package scripts
rvm_path="$home/.rvm/scripts/rvm"

if ! grep -q "$rvm_path" $home/.bash_profile; then
  echo "source $rvm_path" >> $home/.bash_profile
  source $home/.bash_profile
fi

# install rubies
$as_vagrant 'rvm install jruby'
$as_vagrant 'rvm install 1.8.7-p374 && rvm alias create 1.8.7 1.8.7-p374'
$as_vagrant 'rvm install 1.9.3-p551 && rvm alias create 1.9.3 1.9.3-p551'
$as_vagrant 'rvm install 2.0.0-p648 && rvm alias create 2.0.0 2.0.0-p648'
$as_vagrant 'rvm install 2.1.8'
$as_vagrant 'rvm install 2.2.4'

# install bundler into every ruby
$as_vagrant 'rvm all do gem install bundler'

# add /vagrant/bin to the PATH
if ! grep -q "/vagrant/bin" $home/.bash_profile; then
  echo "export PATH=\$PATH:/vagrant/bin" >> $home/.bash_profile
fi
