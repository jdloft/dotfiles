# google cloud
if [ -f "/usr/share/google-cloud-sdk/completion.zsh.inc" ]; then
    source /usr/share/google-cloud-sdk/completion.zsh.inc
fi
if [ -f "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then
    source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

cache_completion() {
    if (( $+commands[$1] )); then
        if [[ ! -f "$ZSH_CACHE_DIR/completions/_$1" ]]; then
            $1 completion zsh | tee "$ZSH_CACHE_DIR/completions/_$1" >/dev/null
            source "$ZSH_CACHE_DIR/completions/_$1"
        else
            source "$ZSH_CACHE_DIR/completions/_$1"
            $1 completion zsh | tee "$ZSH_CACHE_DIR/completions/_$1" >/dev/null &|
        fi
    fi
}

cache_completion "kubectl"
cache_completion "helm"
cache_completion "kubeadm"
