#!/bin/sh

# Solarized dircolors
if [[ ! is_mac ]]; then
    eval `dircolors $DOTFILES/lib/dircolors-solarized/dircolors.ansi-dark`
fi
