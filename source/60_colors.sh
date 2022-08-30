#!/bin/sh

if [[ $- == *i* ]]; then # if we're interactive
    if [ $SOLAR_MODE3 = true ]; then
        eval sh $DOTFILES/scripts/solar_mode3.sh
    fi

    # Solarized dircolors
    if type dircolors > /dev/null 2>&1; then
        eval `dircolors $DOTFILES/resources/dircolors-solarized/dircolors.ansi-dark`
    fi
fi
