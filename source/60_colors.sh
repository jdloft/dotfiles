#!/bin/sh

# Solarized dircolors
if [[ ! is_mac == 0 ]]; then
    eval `dircolors $DOTFILES/lib/dircolors-solarized/dircolors.ansi-dark`
fi
