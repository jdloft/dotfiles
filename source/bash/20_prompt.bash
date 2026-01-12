function _dotfiles-prompt() {
    local ec="$?"
    local host="\h"
    local clr_user="$CLR_BLUE"
    local clr_host="$CLR_YELLOW"
    local prompt="\$"
    local supports_color

    # Root is special
    if [ "$LOGNAME" = "root" ]; then
        clr_user="$CLR_RED"
        prompt="#"
    fi

    if [ "$host" = "toolbox" ]; then
        clr_host="$CLR_RED"
    fi

    # Test for color support
    if [ -x /usr/bin/tput ] && tput setaf 1 >/dev/null 2>&1; then
        supports_color=1
    fi

    # Actual prompt code
    if [[ -n $supports_color ]]; then
        PS1="\[$CLR_NONE\]"
        PS1+="$(_dotfiles-exit_code "$ec")"
        PS1+="\[$clr_user\]\u\[$CLR_NONE\]@\[$clr_host\]$host"
        PS1+="\[$CLR_NONE\]$(_dotfiles-chroot-prompt) "
        PS1+="\[$CLR_BLUE\]\w"

        if command -v git >/dev/null 2>&1; then
            PS1+="$(_dotfiles-git-prompt)"
        fi

        PS1+="$(_dotfiles-virtualenv-prompt)"
        if [[ -n $K8S_PROMPT ]]; then
            PS1+="$(_dotfiles-k8s-prompt)"
        fi
        PS1+="\[$CLR_NONE\] $prompt "
    else
        PS1="\u@$host:\w$prompt "
    fi
}

function _dotfiles-exit_code() {
    local ec="$1"
    [[ $ec != 0 ]] && printf '\[%s\]%s\[%s\] ' "$CLR_RED" "$ec" "$CLR_NONE"
}

function _dotfiles-chroot-prompt() {
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(< /etc/debian_chroot)
        printf '\[%s\] (%s)\[%s\]' "$CLR_YELLOW" "$debian_chroot" "$CLR_NONE"
    fi
}

#
# Git status
# Based on the "official" git-completion.bash
# But more simplified and with colors.
#
function _dotfiles-git-prompt() {
    local indicator=""
    local branch=""

    local CLR_GITST_CLS="$CLR_GREEN"
    local CLR_GITST_SC="$CLR_YELLOW"
    local CLR_GITST_USC="$CLR_RED"
    local CLR_GITST_UT="$CLR_CYAN"
    local CLR_GITST_BR="$CLR_GREEN"

    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1

    if git diff-index --cached HEAD -- >/dev/null 2>&1 && [[ -n "$(git diff-index --cached HEAD -- 2>/dev/null)" ]]; then
        # ls-files has no way to list files that are staged, we have to use the
        # significantly slower (for large repos)  diff-index command instead
        indicator+='\['"$CLR_GITST_SC"'\]+' # Staged changes
    fi
    if [[ -n "$(git ls-files --modified 2>/dev/null)" ]]; then
        indicator+='\['"$CLR_GITST_USC"'\]*' # Unstaged changes
    fi
    if [[ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
        indicator+='\['"$CLR_GITST_UT"'\]?' # Untracked files
    fi

    branch="$(git branch --no-color 2>/dev/null | sed -n 's/^\* //p')"
    printf '\[%s\] (\[%s\]%s%s\[%s\])' "$CLR_GITST_CLS" "$CLR_GITST_BR" "$branch" "$indicator" "$CLR_GITST_CLS"
}

function _dotfiles-virtualenv-prompt() {
    local environment=""
    if [[ -n $VIRTUAL_ENV ]]; then
        environment="${VIRTUAL_ENV##*/}"
    elif [[ -n $CONDA_DEFAULT_ENV ]]; then
        environment="${CONDA_DEFAULT_ENV##*/}"
    else
        return 1
    fi
    printf '\[%s\] (%s)\[%s\]' "$CLR_YELLOW" "$environment" "$CLR_YELLOW"
}

function _dotfiles-k8s-prompt() {
    local current_context=""
    current_context="$(kubectl config current-context 2>/dev/null)" || return 1
    [[ -z $current_context ]] && return 1
    printf '\[%s\] (%s)\[%s\]' "$CLR_BLUE" "$current_context" "$CLR_BLUE"
}

PROMPT_COMMAND="_dotfiles-prompt"
