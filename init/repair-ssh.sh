#!/bin/bash
if [ -h ~/.ssh ]; then
    echo "~/.ssh is a symlink, repairing"
    rm ~/.ssh
    mkdir ~/.ssh
    mv ~/.dotfiles/link/.ssh/* ~/.ssh
    rm -r ~/.dotfiles/link/.ssh
    echo "Repair complete!"
fi
