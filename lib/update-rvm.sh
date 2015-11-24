#!/bin/sh
cd /tmp
echo "Downloading RVM stable package..."
echo "(Make sure curl is installed or stuff will blow up)"
curl -sSL https://github.com/rvm/rvm/tarball/stable -o rvm-stable.tar.gz
if [ ! -e rvm-stable.tar.gz ]; then
    echo "Stuff blew up (downloaded package not found)."
    echo "Make sure curl is installed and you are connected to the internet."
    exit
fi
mkdir rvm-stable
echo "Extracting package..."
tar -xvzf rvm-stable.tar.gz --strip-components=1 -C rvm-stable
cd rvm-stable
echo "Running install..."
./install --ignore-dotfiles --path $DOTFILES/lib/rvm
echo "RVM is now updated. Please commit the lib/rvm directory."
