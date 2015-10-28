# Where the magic happens.
export DOTFILES=~/.dotfiles

# Add binaries into the path
typeset -U path
path=($DOTFILES/bin $path[@])
