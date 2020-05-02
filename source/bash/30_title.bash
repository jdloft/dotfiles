function _dotfiles-title() {
    # from /etc/profile.d/vte.sh
    local command=$(HISTTIMEFORMAT= history 1 | sed 's/^ *[0-9]\+ *//')
    command="${command//;/ }"
    local pwd='~'
    [ "$PWD" != "$HOME" ] && pwd=${PWD/#$HOME\//\~\/}
    pwd="${pwd//[[:cntrl:]]}"
    printf '\033]777;notify;Command completed;%s\033\\\033]777;precmd\033\\\033]0;%s@%s:%s\033\\' "${command}" "${USER}" "$host" "${pwd}"
}