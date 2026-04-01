if [[ "$TERM" != "dumb" && "$TERM" != "linux" ]]; then
    autoload -U add-zsh-hook
    function _dotfiles_titleinfo() {
        local host="$DOTFILES_HOST"
        local rel="${PWD#$HOME}"
        local display="$([[ "$rel" != "$PWD" ]] && echo "~$rel" || echo "$PWD")"
        printf '\033]0;%s@%s:%s\033\\' "$USER" "$host" "$display"
    }
    add-zsh-hook precmd _dotfiles_titleinfo
fi
