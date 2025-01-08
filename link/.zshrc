DEBUG=0
if [ $DEBUG -gt 0 ]; then
    zmodload zsh/zprof
fi

# Source all files in "source"
function src() {
    local file start_time end_time elapsed_time

    if [ -f "$HOME/.zshrc.pre" ]; then
        if [ $DEBUG -gt 0 ]; then
            echo "Sourcing .zshrc.pre"
        fi
        source "$HOME/.zshrc.pre"
    fi

    for file in $DOTFILES/source/*; do
        if [ -f "$file" ]; then
            if [ $DEBUG -gt 0 ]; then
                start_time=$(date +%s%N)
                source "$file"
                end_time=$(date +%s%N)
                elapsed_time=$(( (end_time - start_time) / 1000000 ))
                echo "Sourced $file in ${elapsed_time} ms"
            else
                source "$file"
            fi
        fi
    done

    for file in $DOTFILES/source/zsh/*; do
        if [ -f "$file" ]; then
            if [ $DEBUG -gt 0 ]; then
                start_time=$(date +%s%N)
                source "$file"
                end_time=$(date +%s%N)
                elapsed_time=$(( (end_time - start_time) / 1000000 ))
                echo "Sourced $file in ${elapsed_time} ms"
            else
                source "$file"
            fi
        fi
    done

    if [ -f "$HOME/.zshrc.post" ]; then
        if [ $DEBUG -gt 0 ]; then
            start_time=$(date +%s%N)
            source "$HOME/.zshrc.post"
            end_time=$(date +%s%N)
            elapsed_time=$(( (end_time - start_time) / 1000000 ))
            echo "Sourced .zshrc.post in ${elapsed_time} ms"
        else
            source "$HOME/.zshrc.post"
        fi
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
