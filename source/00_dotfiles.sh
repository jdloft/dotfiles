# Passing the "source" arg tells it to only define functions, then quit.
source $DOTFILES/bin/dotfiles --source

# Set dotfiles host
export DOTFILES_HOST="$( hostname -s 2>/dev/null )"
export DOTFILES_LHOST="$( hostname -f 2>/dev/null )"
