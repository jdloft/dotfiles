# Setup PATH

# Add binaries into the path
PATH="$DOTFILES/bin:$PATH"

# rbenv
PATH="$(path_remove $DOTFILES/lib/rbenv/bin):$DOTFILES/lib/rbenv/bin"

export PATH
