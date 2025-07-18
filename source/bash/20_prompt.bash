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
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        supports_color=1
    fi

    # Actual prompt code
    if [[ -n $supports_color ]]; then
        PS1="\[$CLR_NONE\]"
        PS1+="$(_dotfiles-exit_code)"
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
    [[ $ec != 0 ]] && echo "\[$CLR_RED\]$ec\[$CLR_NONE\] "
}

function _dotfiles-chroot-prompt() {
    # Chroot info
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
        echo "\[$CLR_YELLOW\] ($debian_chroot)\[$CLR_NONE\]"
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

    CLR_GITST_CLS="\[$CLR_GREEN\]" # Clear state
    CLR_GITST_SC="\[$CLR_YELLOW\]" # Staged changes indicator
    CLR_GITST_USC="\[$CLR_RED\]" # Unstaged changes indicator
    CLR_GITST_UT="\[$CLR_CYAN\]" # Untracked files indicator
    CLR_GITST_BR="\[$CLR_GREEN\]" # Branch

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
        indicator="$indicator${CLR_GITST_UT}?" # Untracked files
    fi

    branch="`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`"
    echo -en "${CLR_GITST_CLS} (${CLR_GITST_BR}$branch$indicator${CLR_GITST_CLS})"
}

function _dotfiles-virtualenv-prompt() {
    CLR_VE_CLS="\[$CLR_YELLOW\]"
    CLR_VE_ENV="\[$CLR_YELLOW\]"

    if [[ $VIRTUAL_ENV != "" ]]; then
        environment="${VIRTUAL_ENV##*/}"
    elif [[ $CONDA_DEFAULT_ENV != "" ]]; then
        environment="${CONDA_DEFAULT_ENV##*/}"
    else
        return 1
    fi

    echo -en "${CLR_VE_CLS} (${CLR_VE_ENV}$environment${CLR_VE_CLS})"
}

function _dotfiles-k8s-prompt() {
    CLR_K8S_CLS="\[$CLR_BLUE\]"
    CLR_K8S_ENV="\[$CLR_BLUE\]"

    current_context="$(kubectl config current-context 2> /dev/null)"
    if [ $? -ne 0 ] || [ -z "$current_context" ]; then
        return 1
    fi

    echo -en "${CLR_K8S_CLS} (${CLR_K8S_ENV}$current_context${CLR_K8S_CLS})"
}

PROMPT_COMMAND="_dotfiles-prompt"
