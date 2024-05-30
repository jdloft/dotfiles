DEBUG=0
if [ $DEBUG -gt 0 ]; then
    zmodload zsh/zprof
fi

# Source all files in "source"
function src() {
    local file
    if [ -f "$HOME/.zshrc.pre" ]; then
        if [ $DEBUG -gt 0 ]; then
            echo "Sourcing .zshrc.pre"
        fi
        source "$HOME/.zshrc.pre"
    fi
    for file in $DOTFILES/source/*; do
        if [ -f "$file" ]; then
            if [ $DEBUG -gt 0 ]; then
                echo "Sourcing $file"
            fi
            source "$file"
        fi
    done
    for file in $DOTFILES/source/zsh/*; do
        if [ -f "$file" ]; then
            if [ $DEBUG -gt 0 ]; then
                echo "Sourcing $file"
            fi
            source "$file"
        fi
    done
    if [ -f "$HOME/.zshrc.post" ]; then
        if [ $DEBUG -gt 0 ]; then
            echo "Sourcing .zshrc.post"
        fi
        source "$HOME/.zshrc.post"
    fi
}

# Run dotfiles script, then source.
function dotfiles() {
    $DOTFILES/bin/dotfiles "$@" && src
}

src

if [ $DEBUG -gt 0 ]; then
    zprof
fi
