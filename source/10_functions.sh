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
    CLR_GITST_UT="$CLR_CYAN" # Untracked files indicator
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
        indicator="$indicator${CLR_GITST_UT}?" # Untracked files
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
