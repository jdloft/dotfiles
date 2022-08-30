#!/bin/sh

if [[ $- == *i* ]]; then # if we're interactive
    if [ $SOLAR_MODE3 = true ]; then
        eval sh $DOTFILES/scripts/solar_mode3.sh
    fi
fi
