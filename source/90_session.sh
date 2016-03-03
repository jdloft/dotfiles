#!/bin/bash
# starts tmux, etc.

if [[ ! -z $PS1 ]]; then
    if [[ -z $TMUX ]]; then
        if [ "$DOTFILES_HOST" = "hydrogen" ]; then
            go-session main
        fi
    fi
fi
