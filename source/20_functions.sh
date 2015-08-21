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

    # Actual prompt code
    if [[ -n $supportcolor ]]; then
        if [ "$labshost" = true ]; then
            PS1="\[$CLR_WHITE\][\$(date +%H:%M\ %Z)] \[$clr_user\]\u\[$CLR_WHITE\] at \[$CLR_RED\]$host.\[$CLR_BOLD\]$project\[$CLR_NONE\]\[$CLR_RED\].\[$CLR_LINE\]$cluster\[$CLR_NONE\]\[$CLR_RED\].$site\[$CLR_WHITE\] in \[$CLR_YELLOW\]\w\$(_dotfiles-git-prompt)\$(_dotfiles-virtualenv-prompt)\[$CLR_NONE\]\n$(_dotfiles-exit_code $ec)\[$CLR_WHITE\]$prompt\[$CLR_NONE\] "
        else
            PS1="\[$CLR_WHITE\][\$(date +%H:%M\ %Z)] \[$clr_user\]\u\[$CLR_WHITE\] at \[$clr_host\]$host\[$CLR_WHITE\] in \[$CLR_YELLOW\]\w\$(_dotfiles-git-prompt)\$(_dotfiles-virtualenv-prompt)\[$CLR_NONE\]\n$(_dotfiles-exit_code $ec)\[$CLR_WHITE\]$prompt\[$CLR_NONE\] "
        fi
    else
        PS1="[\$(date +%H:%M\ %Z)] \u@$host:\w$prompt "
    fi
}

#
# Git status
# Based on the "official" git-completion.bash
# But more simplified and with colors.
#
function _dotfiles-git-prompt() {
    local st_staged=0
    local st_unstaged=0
    local st_untracked=0
    local indicator
    local branch

    CLR_GITST_CLS="$CLR_GREEN" # Clear state
    CLR_GITST_SC="$CLR_YELLOW" # Staged changes indicator
    CLR_GITST_USC="$CLR_RED" # Unstaged changes indicator
    CLR_GITST_UT="$CLR_WHITE" # Untracked files indicator
    CLR_GITST_BR="$CLR_GREEN" # Branch

    if [[ -z "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then
        return 1
    fi

    if [[ -n "$(git diff-index --cached HEAD 2> /dev/null)" ]]; then
        # ls-files has no way to list files that are staged, we have to use the
        # significantly slower (for large repos)  diff-index command instead
        indicator="$indicator${CLR_GITST_SC}+" # Staged changes
    fi
    if [[ -n "$(git ls-files --modified 2> /dev/null)" ]]; then
        indicator="$indicator${CLR_GITST_USC}*" # Unstaged changes
    fi
    if [[ -n "$(git ls-files --others --exclude-standard 2> /dev/null)" ]]; then
        indicator="$indicator${CLR_GITST_UT}%" # Untracked files
    fi

    branch="`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`"
    echo -en "${CLR_GITST_CLS} (${CLR_GITST_BR}$branch$indicator${CLR_GITST_CLS})"
}

function _dotfiles-virtualenv-prompt() {
    CLR_VE_CLS="$CLR_YELLOW"
    CLR_VE_ENV="$CLR_YELLOW"

    if [[ $VIRTUAL_ENV != "" ]]; then
        environment="${VIRTUAL_ENV##*/}"
    else
        return 1
    fi

    echo -en "${CLR_VE_CLS} (${CLR_VE_ENV}$environment${CLR_VE_CLS})"
}

# Password generation
# Courtesy of @tstarling
function genpass() {
    tr -cd [:alnum:] < /dev/urandom | head -c10
    echo
}

# Open keys
function open-keys() {
    if [[ -e ~/.ssh/id_rsa || -e ~/.ssh/id_dsa ]]; then
        if [ -z "$SSH_AUTH_SOCK" ]; then
            eval `ssh-agent -s`
            ssh-add
        fi
    fi
}
