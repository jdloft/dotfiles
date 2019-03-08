function _dotfiles-prompt() {
    local host="$DOTFILES_HOST"
    local clr_user="%F{cyan}"
    local clr_host="%F{cyan}"

    # Root is special
    if [ "$LOGNAME" = "root" ]; then
        clr_user="%F{red}"
        promptchar="#"
    fi

    # Actual prompt code
    echo "%f[$(date +%H:%M\ %Z)] $clr_user%n%f at $clr_host$host%f$(_dotfiles-chroot-prompt) in %F{yellow}${PWD/#$HOME/~}%f"
}

function _dotfiles-prompt2() {
    local promptchar="\$"
    echo "%f\n$(_dotfiles-exit_code)$promptchar%f "
}

function _dotfiles-exit_code() {
    echo "%(?..%F{red}%?%f )"
}

function _dotfiles-chroot-prompt() {
    CLR_CHROOT_CLS="%F{yellow}"

    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        echo -en "${CLR_CHROOT_CLS} ($(cat /etc/debian_chroot))%f"
    fi
}

# Git status
function _dotfiles-git-prompt() {
    local st_staged=0
    local st_unstaged=0
    local st_untracked=0
    local indicator
    local branch

    CLR_GITST_CLS="%F{green}" # Clear state
    CLR_GITST_SC="%F{yellow}" # Staged changes indicator
    CLR_GITST_USC="%F{red}" # Unstaged changes indicator
    CLR_GITST_UT="%F{cyan}" # Untracked files indicator
    CLR_GITST_BR="%F{green}" # Branch

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
    echo -en "${CLR_GITST_CLS} (${CLR_GITST_BR}$branch$indicator${CLR_GITST_CLS})%f"
}

function _dotfiles-virtualenv-prompt() {
    CLR_VE_CLS="%F{yellow}"
    CLR_VE_ENV="%F{yellow}"

    if [[ $VIRTUAL_ENV != "" ]]; then
        environment="${VIRTUAL_ENV##*/}"
    else
        return 1
    fi

    echo -en "${CLR_VE_CLS} (${CLR_VE_ENV}$environment${CLR_VE_CLS})%f"
}

function _dotfiles-desk-prompt() {
    CLR_DESK_CLS="%F{cyan}"
    CLR_DESK_ENV="%F{cyan}"

    if [[ $DESK_NAME == "" ]]; then
        return 1
    fi

    echo -en "${CLR_DESK_CLS} (${CLR_DESK_ENV}$DESK_NAME${CLR_DESK_CLS})%f"
}

PROMPT='$(_dotfiles-prompt)$(_dotfiles-virtualenv-prompt)$(_dotfiles-desk-prompt)$(_dotfiles-prompt2)'
RPROMPT='$(_dotfiles-git-prompt)'
