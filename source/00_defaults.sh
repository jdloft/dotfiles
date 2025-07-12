# Default variables
# Can be changed in 01_local.sh without committing to git

# Solarized mode
# see .vimrc
export SOLAR_MODE=${SOLAR_MODE:-mode3}

# Set dotfiles host
if command -v hostname &> /dev/null; then
    export DOTFILES_HOST=`hostname -s 2>/dev/null`
    export DOTFILES_LHOST=`timeout 0.2 hostname -f 2>/dev/null || echo $DOTFILES_HOST`
else
    export DOTFILES_HOST=`cat /etc/hostname`
    export DOTFILES_LHOST=$DOTFILES_HOST
fi

# Editor
if command -v vim &> /dev/null; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# Misc
export VIRTUAL_ENV_DISABLE_PROMPT=1
