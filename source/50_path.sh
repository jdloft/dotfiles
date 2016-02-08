# Setup PATH

# Add ~/bin to PATH
if [ -d "~/bin" ]; then
    path_prepend "~/bin"
fi

# Add dotfiles bin dir
path_prepend "$DOTFILES/bin"

# rbenv
path_append "$DOTFILES/lib/rbenv/bin"
