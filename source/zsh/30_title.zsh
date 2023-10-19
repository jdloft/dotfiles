if ! is_mac; then
    autoload -U add-zsh-hook
    function _dotfiles-titleinfo() {
        local host="$DOTFILES_HOST"
        # from /etc/profile.d/vte.sh
        # local command=$(HISTTIMEFORMAT= history 1 | sed 's/^ *[0-9]\+ *//')
        # command="${command//;/ }"
        # printf '\033\\\033]777;precmd\033\\\033]0;%s@%s:%s\033\\' "$USER" "$host" "${PWD/#$HOME/~}"
        # printf '\033]0;%s@%s:%s' "%n" "$host" "${PWD/#$HOME/~}"
        # echo -en '\033]0;$("%n")@$("$host"):${PWD/#$HOME/~}\033\\'
        printf '\033]777;notify;Command completed;%s\033\\\033]777;precmd\033\\\033]0;%s@%s:%s\033\\' "${command}" "$USER" "$host" "${PWD/#$HOME/~}"
    }

    add-zsh-hook precmd _dotfiles-titleinfo

    function _dotfiles-oscpreexec() {
        printf "\033]777;preexec\033\\"
    }

    add-zsh-hook preexec _dotfiles-oscpreexec
fi
