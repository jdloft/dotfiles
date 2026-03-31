if [[ "$TERM" != "dumb" && "$TERM" != "linux" ]]; then
    function _dotfiles_titleinfo() {
        local host="$DOTFILES_HOST"
        local rel="${PWD#$HOME}"
        local display="$([[ "$rel" != "$PWD" ]] && echo "~$rel" || echo "$PWD")"
        printf '\033]0;%s@%s:%s\033\\' "$USER" "$host" "$display"
    }
    PROMPT_COMMAND="_dotfiles_titleinfo${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
