# Setup PATH

# Add dotfiles bin dir
path_prepend "$DOTFILES/bin"

# Add ~/bin to PATH
if [ -d "$HOME/bin" ]; then
    path_prepend "$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ]; then
    path_prepend "$HOME/.local/bin"
fi

# Python
# TODO: add Linux support
if is_mac && [ -d "$HOME/Library/Python" ]; then
    for directory in ~/Library/Python/*/; do
        if [ -d "${directory}bin" ]; then # output from for has a trailing slash
            path_append "${directory}bin"
        fi
    done
fi
