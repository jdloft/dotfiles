# Source all files in "source"
function src() {
    local file
    if [ -f "$HOME/.zshrc.pre" ]; then
        source "$HOME/.zshrc.pre"
    fi
    for file in $DOTFILES/source/*; do
        if [[ -f "$file" ]]; then
            source "$file"
        fi
    done
    for file in $DOTFILES/source/zsh/*; do
        if [[ -f "$file" ]]; then
            source "$file"
        fi
    done
    if [ -f "$HOME/.zshrc.post" ]; then
        source "$HOME/.zshrc.post"
    fi
}

# Run dotfiles script, then source.
function dotfiles() {
    $DOTFILES/bin/dotfiles "$@" && src
}

src
