function _dotfiles-prompt() {
    local host="$DOTFILES_HOST"
    local clr_user="%F{blue}"
    local clr_host="%F{yellow}"

    # Root is special
    if [ "$LOGNAME" = "root" ]; then
        clr_user="%F{red}"
    fi

    if [ "$host" = "toolbox" ]; then
        clr_host="%F{red}"
    fi

    # Actual prompt code
    # %n = username
    echo "%f$(_dotfiles-exit_code)$clr_user%n%f@$clr_host$host%f$(_dotfiles-chroot-prompt) %F{blue}${PWD/#$HOME/~}%f"
}

function _dotfiles-prompt2() {
    local promptchar="\$"

    if [ "$LOGNAME" = "root" ]; then
        promptchar="#"
    fi

    echo " $promptchar%f "
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
    elif [[ $CONDA_DEFAULT_ENV != "" ]]; then
        environment="$CONDA_DEFAULT_ENV"
    else
        return 1
    fi

    echo -en "${CLR_VE_CLS} (${CLR_VE_ENV}$environment${CLR_VE_CLS})%f"
}

function _dotfiles-desk-prompt() {
    CLR_DESK="%F{cyan}"

    if [[ $DESK_NAME == "" ]]; then
        return 1
    fi

    echo -en "${CLR_DESK} ◲%f"
}

function _dotfiles-k8s-prompt() {
    CLR_K8S_CLS="%F{blue}"
    CLR_K8S_ENV="%F{blue}"

    current_context="$(kubectl config current-context)"

    if [ $? -ne 0 ]; then
        return 1
    fi

    echo -en "${CLR_K8S_CLS} (${CLR_K8S_ENV}$current_context${CLR_K8S_CLS})%f"
}

PROMPT='$(_dotfiles-prompt)$(_dotfiles-virtualenv-prompt)$(_dotfiles-desk-prompt)$(_dotfiles-prompt2)'

if [[ -n $K8S_PROMPT ]]; then
    RPROMPT='$(_dotfiles-git-prompt)$(_dotfiles-k8s-prompt)'
else
    RPROMPT='$(_dotfiles-git-prompt)'
fi
