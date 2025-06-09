# conda + mamba init
FORGE_DIRS=(
    "$HOME/miniforge3"
    "/opt/homebrew/Caskroom/miniforge/base"
    "/opt/homebrew/miniforge3"
)

find_forge_dir() {
    for path in "${FORGE_DIRS[@]}"; do
        if [ -d "$path" ]; then
            echo "$path"
            return 0
        fi
    done
    return 1
}

FORGE_DIR="$(find_forge_dir)"

if [ -n "$FORGE_DIR" ]; then
    __conda_setup="$('$FORGE_DIR/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

    export MAMBA_EXE="$FORGE_DIR/bin/mamba";
    if [ -f $MAMBA_EXE ]; then
        # find better mac dir?
        export MAMBA_ROOT_PREFIX="$HOME/.local/share/mamba";
        __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__mamba_setup"
        else
            alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
        fi
        unset __mamba_setup
    fi
fi

# if is_mac; then
#     # Google SDK
#     if [ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
#         source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
#         path_append /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
#     fi
#     if [ -d "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
#         source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
#         path_append /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
#     fi
# fi
