# If extra zsh-completions repo is available, use it
if [[ -d "$DOTFILES/lib/zsh-completions/src" ]]; then
    fpath=("$DOTFILES/lib/zsh-completions/src" $fpath)
fi
