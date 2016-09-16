# If extra zsh-completions repo is available, use it
if [[ -d "$DOTFILES/lib/zsh-completions" ]]; then
    fpath=("$DOTFILES/lib/zsh-completions" $fpath)
fi
