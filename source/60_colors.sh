#!/bin/sh

# Solarized dircolors
if ! is_mac; then
    eval `dircolors $DOTFILES/resources/dircolors-solarized/dircolors.ansi-dark`
fi
