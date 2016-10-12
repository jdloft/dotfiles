#!/bin/sh

# Solarized dircolors
if [[ ! is_mac == 1 ]]; then
    eval `dircolors $DOTFILES/lib/dircolors-solarized/dircolors.ansi-dark`
fi
