# Default variables
# Can be changed in 01_local.sh without committing to git

# Solarized modes
# see .vimrc
export NO_SOLAR=${NO_SOLAR:-false}
export SOLAR_MODE2=${SOLAR_MODE2:-true}
export SOLAR_MODE3=${SOLAR_MODE3:-true}

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
