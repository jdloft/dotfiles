# Where the magic happens.
export DOTFILES=~/.dotfiles

DEBUG=0

# Source all files in "source"
function src() {
    local file
    if [ -f "$HOME/.bashrc.pre" ]; then
        if [ $DEBUG -gt 0 ]; then
            echo "Sourcing .bashrc.pre"
        fi
        source "$HOME/.bashrc.pre"
    fi
    for file in $DOTFILES/source/*; do
        if [ -f "$file" ]; then
            if [ $DEBUG -gt 0 ]; then
                echo "Sourcing $file"
            fi
            source "$file"
        fi
    done
    for file in $DOTFILES/source/bash/*; do
        if [ -f "$file" ]; then
            if [ $DEBUG -gt 0 ]; then
                echo "Sourcing $file"
            fi
            source "$file"
        fi
    done
    if [ -f "$HOME/.bashrc.post" ]; then
        if [ $DEBUG -gt 0 ]; then
            echo "Sourcing .bashrc.post"
        fi
        source "$HOME/.bashrc.post"
    fi
}

# Run dotfiles script, then source.
function dotfiles() {
    $DOTFILES/bin/dotfiles "$@" && src
}

src
