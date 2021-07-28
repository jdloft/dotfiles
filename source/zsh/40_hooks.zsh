# conda
if [ -d "$HOME/miniforge3/" ]; then
    FORGE_DIR="$HOME/miniforge3"
    __conda_setup="$('$FORGE_DIR/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$FORGE_DIR/etc/profile.d/conda.sh" ]; then
            . "$FORGE_DIR/etc/profile.d/conda.sh"
        else
            export PATH="$FORGE_DIR/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi

if is_mac; then
    # Google SDK
    if [ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
        path_append /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
    fi
    if [ -d "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
        source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
        path_append /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
    fi
fi
