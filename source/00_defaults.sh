# Default variables
# Can be changed in 01_local.sh without committing to git

# Solarized modes
export NO_SOLAR=false
export SOLAR_MODE2=true
export SOLAR_MODE3=true

# Set dotfiles host
export DOTFILES_HOST="$( hostname -s 2>/dev/null )"
export DOTFILES_LHOST="$( hostname -f 2>/dev/null )"
