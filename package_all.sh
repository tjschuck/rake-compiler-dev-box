#!/usr/bin/env bash

set -e
source "$HOME/.rvm/scripts/rvm"

./package_native.sh $1
./package_java.sh $1
./package_win32_fat_binary.sh $1
