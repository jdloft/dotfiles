#!/bin/sh

# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

# Set desk dir based on host
if [ "$DOTFILES_HOST" = "jdloft" ]; then
    export DESK_DESKS_DIR=~/.desk/desks/neon/
elif [[ $DOTFILES_LHOST == *".tools.eqiad.wmflabs" ]]; then
    export DESK_DESKS_DIR=~/.desk/desks/tools/
elif [ "$DOTFILES_HOST" = "titanium" ]; then
    export DESK_DESKS_DIR=~/.desk/desks/titanium/
elif [ "$DOTFILES_HOST" = "hydrogen" ]; then
    export DESK_DESKS_DIR=~/.desk/desks/hydrogen/
fi
