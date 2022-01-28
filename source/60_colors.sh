#!/bin/sh

if [[ $- == *i* ]]; then
    if [ $SOLAR_MODE3 = true ]; then
        eval $DOTFILES/scripts/solar_mode3.sh
    fi

    # Solarized dircolors
    if ! is_mac; then
        eval `dircolors $DOTFILES/resources/dircolors-solarized/dircolors.ansi-dark`
    fi
fi
