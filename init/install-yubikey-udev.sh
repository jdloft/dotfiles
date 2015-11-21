#!/bin/bash
echo "This script installs the Yubikey udev rules with root privileges."
echo "Only do this on personal computers!"
read -p "Would you like to continue? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -e /etc/udev/rules.d/70-u2f.rules ]; then
        echo "File already exists. Aborting..."
    else
        sudo cp ~/.dotfiles/lib/70-u2f.rules /etc/udev/rules.d/
        sudo service udev restart
        echo "Please remove and reinsert the Yubikey if plugged in to apply changes."
        echo "Done!"
    fi
else
    echo "Aborting."
fi
