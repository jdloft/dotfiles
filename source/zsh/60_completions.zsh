# google cloud
if [ -f "/usr/share/google-cloud-sdk/completion.zsh.inc" ]; then
    source /usr/share/google-cloud-sdk/completion.zsh.inc
fi
if [ -f "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then
    source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

patch_cobra() {
    # workaround for https://github.com/spf13/cobra/issues/1694
    # kubectl and helm
    # https://github.com/kubernetes/kubernetes/issues/105587
    if [[ $1 == "kubectl" || $1 == "helm" ]]; then
        sed -i '' -e 's/tab=$(printf \x27\\t\x27)/tab="$(printf \x27\\t\x27)"/' $ZSH_CACHE_DIR/completions/_$1
    fi
}

cache_completion() {
    if (( $+commands[$1] )); then
        if [[ ! -f "$ZSH_CACHE_DIR/completions/_$1" ]]; then
            $1 completion zsh | tee "$ZSH_CACHE_DIR/completions/_$1" >/dev/null
            patch_cobra $1
            source "$ZSH_CACHE_DIR/completions/_$1"
        else
            patch_cobra $1
            source "$ZSH_CACHE_DIR/completions/_$1"
            $1 completion zsh | tee "$ZSH_CACHE_DIR/completions/_$1" >/dev/null &|
        fi
    fi
}

cache_completion "kubectl"
cache_completion "helm"
cache_completion "kubeadm"
