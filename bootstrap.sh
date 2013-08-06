#!/usr/bin/env bash

set -e

as_vagrant='sudo -u vagrant -H bash -l -c'
home='/home/vagrant'

apt-get -y update
apt-get install -y curl git-core mingw32 default-jdk

# Download mingw-w64 compilers
mingw32='i686-w64-mingw32-gcc-4.7.2-release-linux64_rubenvb.tar.xz'
mingw64='x86_64-w64-mingw32-gcc-4.7.2-release-linux64_rubenvb.tar.xz'

$as_vagrant 'mkdir -p ~/mingw'

if [ ! -f "$home/mingw/$mingw32" ]; then
    $as_vagrant "curl -L http://downloads.sourceforge.net/mingw-w64/$mingw32 -o ~/mingw/$mingw32"
    $as_vagrant "tar -C ~/mingw -xf ~/mingw/$mingw32"
fi

if [ ! -f "$home/mingw/$mingw64" ]; then
    $as_vagrant "curl -L http://downloads.sourceforge.net/mingw-w64/$mingw64 -o ~/mingw/$mingw64"
    $as_vagrant "tar -C ~/mingw -xf ~/mingw/$mingw64"
fi

# add mingw-w64 to the PATH
mingw_w64_paths="$home/mingw/mingw32/bin:$home/mingw/mingw64/bin"

if ! grep -q $mingw_w64_paths $home/.bash_profile; then
    echo "export PATH=\$PATH:$mingw_w64_paths" >> $home/.bash_profile
fi

# do not generate documentation for gems

$as_vagrant 'echo "gem: --no-ri --no-rdoc" >> ~/.gemrc'

# install rvm

$as_vagrant 'curl -L https://get.rvm.io | bash -s stable'

$as_vagrant '~/.rvm/bin/rvm install jruby'
$as_vagrant '~/.rvm/bin/rvm install 2.0.0'
$as_vagrant '~/.rvm/bin/rvm install 1.9.3'
$as_vagrant '~/.rvm/bin/rvm install 1.8.7'
