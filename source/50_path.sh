# Setup PATH

# macOS specific stuff

# Python
# TODO: add Linux support
if is_mac; then
    # homebrew
    if [ -d "/opt/homebrew/bin" ]; then
        path_append "/opt/homebrew/bin"
    fi

    if [ -d "$HOME/Library/Python" ]; then
        for directory in ~/Library/Python/*/; do
            if [ -d "${directory}bin" ]; then # output from for has a trailing slash
                path_append "${directory}bin"
            fi
        done
    fi

    # LLVM is keg-only
    if [ -d "/usr/local/opt/llvm/bin" ]; then
        path_prepend "/usr/local/opt/llvm/bin"
    fi

    # Ruby
    if type "rbenv" > /dev/null; then
        eval "$(rbenv init -)"
    elif [ -d "/usr/local/opt/ruby/bin" ]; then
        path_append /usr/local/opt/ruby/bin
    fi
    if [ -d "$HOME/.gem/ruby" ]; then
        for directory in ~/.gem/ruby/*/; do
            if [ -d "${directory}bin" ]; then
                path_append "${directory}bin"
            fi
        done
    fi

    # MacTeX
    if [ -d "/usr/local/texlive/2020/bin/x86_64-darwin" ]; then
        path_append "/usr/local/texlive/2020basic/bin/x86_64-darwin"
    fi
fi

# Add dotfiles bin dir
path_prepend "$DOTFILES/bin"

# Add ~/bin to PATH
if [ -d "$HOME/bin" ]; then
    path_prepend "$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ]; then
    path_prepend "$HOME/.local/bin"
fi

if [ -d "$HOME/go/bin" ]; then
    path_prepend "$HOME/go/bin"
fi

if [ -d "$HOME/.npm/bin" ]; then
    path_prepend "$HOME/.npm/bin"
fi

