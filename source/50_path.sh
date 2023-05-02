# Setup PATH

# macOS specific stuff

# Python
# TODO: add Linux support
if is_mac; then
    # homebrew
    if [ -d "/opt/homebrew/bin" ]; then
        path_prepend "/opt/homebrew/bin"
    fi

    if [ -d "$HOME/Library/Python" ]; then
        for directory in ~/Library/Python/*/; do
            if [ -d "${directory}bin" ]; then # output from for has a trailing slash
                path_prepend "${directory}bin"
            fi
        done
    fi

    # LLVM is keg-only
    if [ -d "/usr/local/opt/llvm/bin" ]; then
        path_prepend "/usr/local/opt/llvm/bin"
    fi

    # Ruby
    if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
        path_prepend "/opt/homebrew/opt/ruby/bin"
    fi
    if [ -d "/opt/homebrew/lib/ruby/gems" ]; then
        for dir in /opt/homebrew/lib/ruby/gems/*; do
            if [ -d "${dir}/bin" ]; then
                path_prepend "${dir}/bin"
            fi
        done
    fi

    # MacTeX
    if [ -d "/usr/local/texlive/2020/bin/x86_64-darwin" ]; then
        path_prepend "/usr/local/texlive/2020basic/bin/x86_64-darwin"
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

if [ -d "$HOME/.krew/bin" ]; then
    path_prepend "$HOME/.krew/bin"
fi
