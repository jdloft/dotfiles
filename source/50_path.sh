# Setup PATH

# macOS specific stuff

# Python
# TODO: add Linux support
if is_mac; then
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

    # Google SDK
    if [ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
        path_append /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
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

if [ -d "$HOME/.npm/bin" ]; then
    path_prepend "$HOME/.npm/bin"
fi

