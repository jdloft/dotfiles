BC="$DOTFILES/resources/bash-completion/bash_completion"
[[ -f "$BC" ]] && source "$BC"

cache_completion() {
    local force=false
    local completion_file="$BASH_CACHE_DIR/completions/_$1"
    local cmd="$1"

    if [[ "$1" == "--force" ]]; then
        force=true
        shift
    fi

    if command -v "$cmd" &>/dev/null; then
        if [[ ! -f "$completion_file" || "$force" == true ]]; then
            "$cmd" completion bash | tee "$completion_file" >/dev/null
        fi

        source "$completion_file"
    fi
}

completion_commands=("kubectl" "helm" "docker" "oc")

regen_completions() {
    for cmd in "${completion_commands[@]}"; do
        cache_completion --force "$cmd"
    done
}

for cmd in "${completion_commands[@]}"; do
    cache_completion "$cmd"
done
