# google cloud
if [ -f "/usr/share/google-cloud-sdk/completion.zsh.inc" ]; then
    source /usr/share/google-cloud-sdk/completion.zsh.inc
fi

if type "kubectl" > /dev/null; then
    source <(kubectl completion zsh)
    complete -F __start_kubectl k
fi

