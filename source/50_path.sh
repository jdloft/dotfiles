# Setup PATH

# Add dotfiles bin dir
path_prepend "$DOTFILES/bin"

# Add ~/bin to PATH
if [ -d "$HOME/bin" ]; then
    path_prepend "$HOME/bin"
fi

# rbenv
path_append "$DOTFILES/lib/rbenv/bin"
