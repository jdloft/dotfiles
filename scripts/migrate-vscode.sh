#!/bin/sh

DIR=~/.config/Code/User/
if is_mac; then
    DIR=~/Library/Application\ Support/Code/User/
fi

files="settings.json keybindings.json"

for file in $files; do
    if [ -L $DIR/$file ]; then
        echo "Migrating $file"
        rm $DIR/$file && cp ~/.dotfiles/Code/User/$file $DIR/$file
    fi
done
echo "Done"
