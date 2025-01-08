# google cloud
if [ -f "/usr/share/google-cloud-sdk/completion.zsh.inc" ]; then
    source /usr/share/google-cloud-sdk/completion.zsh.inc
fi
if is_mac; then
    if [ -f "`brew --prefix`/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then
        source `brew --prefix`/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
    fi
fi

patch_cobra() {
    # workaround for https://github.com/spf13/cobra/issues/1694
    # kubectl and helm
    # https://github.com/kubernetes/kubernetes/issues/105587
    if [[ $1 == "kubectl" || $1 == "helm" ]]; then
        if is_mac; then
            sed -i '' -e 's/tab=$(printf \x27\\t\x27)/tab="$(printf \x27\\t\x27)"/' $ZSH_CACHE_DIR/completions/_$1
        else
            sed -i 's/tab=$(printf \x27\\t\x27)/tab="$(printf \x27\\t\x27)"/' $ZSH_CACHE_DIR/completions/_$1
        fi
    fi
}

cache_completion() {
    local force=false
    local completion_file="$ZSH_CACHE_DIR/completions/_$1"

    if [[ "$1" == "--force" ]]; then
        force=true
        shift
    fi

    # If the command exists, process completions
    if (( $+commands[$1] )); then
        if [[ ! -f "$completion_file" || "$force" == true ]]; then
            $1 completion zsh | tee "$completion_file" >/dev/null
            patch_cobra $1
        fi

        source "$completion_file"
    fi
}

completion_commands=("kubectl" "helm" "docker" "git" "oc")
regen_completions() { # force regen
    for cmd in "${completion_commands[@]}"; do
        cache_completion --force "$cmd"
    done
}

for cmd in "${completion_commands[@]}"; do
    cache_completion "$cmd" # just source the completions if they exist
done
