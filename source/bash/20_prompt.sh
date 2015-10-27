function _dotfiles-exit_code() {
    [[ $1 != 0 ]] && echo "\[$CLR_RED\]$1\[$CLR_NONE\] "
}

# MacOSX default PS1: '\h:\W \u\$'
function _dotfiles-prompt() {
    local ec="$?"
    local host="$DOTFILES_HOST"
    local clr_user="$CLR_CYAN"
    local clr_host="$CLR_CYAN"
    local prompt="\$"
    local supportcolor

    # Special cases
    if [ "$DOTFILES_HOST" = "hydrogen" ]; then
        clr_host="$CLR_BLUE"
    elif [ "$DOTFILES_HOST" = "titanium" ]; then
        clr_host="$CLR_YELLOW"
    elif [ "$DOTFILES_HOST" = "jdloft" ]; then
        host="neon"
        clr_host="$CLR_GREEN"
    # WMF production like servers
    elif echo $DOTFILES_HOST | grep -q -E '\.wikimedia\.org|\.wmnet'; then
        clr_host="$CLR_MAGENTA"
    # WMF labs servers
    elif echo $DOTFILES_HOST | grep -q -E '\.wmflabs'; then
        labshost=true
        site=${host##*.}
        host=${host%.*}
        cluster=${host##*.}
        host=${host%.*}
        project=${host##*.}
        host=${host%.*}
    fi

    # Root is special
    if [ "$LOGNAME" = "root" ]; then
        clr_user="$CLR_RED"
        prompt="#"
    fi

    # Test for color support
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        supportcolor=1
    fi

    # Chroot info
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # Actual prompt code
    if [[ -n $supportcolor ]]; then
        if [ "$labshost" = true ]; then
            PS1="\[$CLR_WHITE\][\$(date +%H:%M\ %Z)] \[$clr_user\]\u\[$CLR_WHITE\] at \[$CLR_RED\]$host.\[$CLR_BOLD\]$project\[$CLR_NONE\]\[$CLR_RED\].\[$CLR_LINE\]$cluster\[$CLR_NONE\]\[$CLR_RED\].$site\[$CLR_WHITE\]${debian_chroot:+\[$CLR_YELLOW\] ($debian_chroot)\[$CLR_NONE\]} in \[$CLR_YELLOW\]\w\$(_dotfiles-git-prompt)\$(_dotfiles-virtualenv-prompt)\[$CLR_NONE\]\n$(_dotfiles-exit_code $ec)\[$CLR_WHITE\]$prompt\[$CLR_NONE\] "
        else
            PS1="\[$CLR_WHITE\][\$(date +%H:%M\ %Z)] \[$clr_user\]\u\[$CLR_WHITE\] at \[$clr_host\]$host\[$CLR_WHITE\]${debian_chroot:+\[$CLR_YELLOW\] ($debian_chroot)\[$CLR_NONE\]} in \[$CLR_YELLOW\]\w\$(_dotfiles-git-prompt)\$(_dotfiles-virtualenv-prompt)\[$CLR_NONE\]\n$(_dotfiles-exit_code $ec)\[$CLR_WHITE\]$prompt\[$CLR_NONE\] "
        fi
    else
        PS1="[\$(date +%H:%M\ %Z)] \u@$host:\w$prompt "
    fi
}
