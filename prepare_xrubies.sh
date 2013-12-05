#!/usr/bin/env bash

set -e
source "$HOME/.rvm/scripts/rvm"

# shared directory between VM and host
cd '/vagrant'

rvm use 1.8.7
gem install rake-compiler -v "~> 0.9.2"

# Build 1.8.7 with mingw32 compiler (GCC 4.2)
rake-compiler cross-ruby VERSION=1.8.7-p374 HOST=i586-mingw32msvc

# Build 1.9.3 using 1.9.3 as base
rvm use 1.9.3
gem install rake-compiler -v "~> 0.9.2"

rake-compiler cross-ruby VERSION=1.9.3-p448 HOST=i586-mingw32msvc

# Use one CPU only for 1.8,7 and 1.9.3, because of a dependency
# issue when building for Windows.
# Use all available CPU cores for compiling Ruby-2.0.
ncpus=`grep -c ^processor /proc/cpuinfo`
if [[ $ncpus -gt 1 ]]; then
    echo "Will use $ncpus workers for make"
    export MAKE="make -j$ncpus"
fi

# Build Ruby 2.0.0
rake-compiler cross-ruby VERSION=2.0.0-p247 HOST=i686-w64-mingw32 debugflags="-g"

# And the icing on the cake: x64 Ruby
rake-compiler cross-ruby VERSION=2.0.0-p247 HOST=x86_64-w64-mingw32 debugflags="-g"
