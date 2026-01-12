function _dotfiles-prompt() {
    local host="%m"
    local clr_user="%F{blue}"
    local clr_host="%F{yellow}"

    # Root is special
    if [[ "$LOGNAME" == "root" ]]; then
        clr_user="%F{red}"
    fi

    if [[ "$host" == "toolbox" ]]; then
        clr_host="%F{red}"
    fi

    # Actual prompt code
    # %n = username
    # Keep exit code segment zsh-native (see _dotfiles-exit_code)
    print -nr -- "%f$(_dotfiles-exit_code)${clr_user}%n%f@${clr_host}${host}%f$(_dotfiles-chroot-prompt) %F{blue}${PWD/#$HOME/~}%f"
}

function _dotfiles-prompt2() {
    local promptchar="\$"
    if [[ "$LOGNAME" == "root" ]]; then
        promptchar="#"
    fi
    print -nr -- " ${promptchar}%f "
}

function _dotfiles-exit_code() {
    # If last command failed, show exit status in red with a trailing space
    print -nr -- "%(?..%F{red}%?%f )"
}

function _dotfiles-chroot-prompt() {
    local CLR_CHROOT_CLS="%F{yellow}"

    if [[ -z "$debian_chroot" && -r /etc/debian_chroot ]]; then
        debian_chroot="$(< /etc/debian_chroot)"
        print -nr -- "${CLR_CHROOT_CLS} (${debian_chroot})%f"
    fi
}

function _dotfiles-git-prompt() {
    local indicator=""
    local branch=""

    local CLR_GITST_CLS="%F{green}"   # Clear state
    local CLR_GITST_SC="%F{yellow}"   # Staged changes indicator
    local CLR_GITST_USC="%F{red}"     # Unstaged changes indicator
    local CLR_GITST_UT="%F{cyan}"     # Untracked files indicator
    local CLR_GITST_BR="%F{green}"    # Branch

    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1

    if [[ -n "$(git diff-index --cached HEAD 2>/dev/null)" ]]; then
        # ls-files has no way to list files that are staged, we have to use the
        # significantly slower (for large repos)  diff-index command instead
        indicator+="${CLR_GITST_SC}+" # Staged changes
    fi
    if [[ -n "$(git ls-files --modified 2>/dev/null)" ]]; then
        indicator+="${CLR_GITST_USC}*" # Unstaged changes
    fi
    if [[ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]]; then
        indicator+="${CLR_GITST_UT}?" # Untracked files
    fi

    branch="$(git branch --no-color 2>/dev/null | sed -n 's/^\* //p')"
    print -nr -- "${CLR_GITST_CLS} (${CLR_GITST_BR}${branch}${indicator}${CLR_GITST_CLS})%f"
}

function _dotfiles-virtualenv-prompt() {
    local CLR_VE_CLS="%F{yellow}"
    local CLR_VE_ENV="%F{yellow}"
    local environment=""

    if [[ -n "$VIRTUAL_ENV" ]]; then
        environment="${VIRTUAL_ENV##*/}"
    elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        environment="${CONDA_DEFAULT_ENV##*/}"
    else
        return 1
    fi

    print -nr -- "${CLR_VE_CLS} (${CLR_VE_ENV}${environment}${CLR_VE_CLS})%f"
}

function _dotfiles-desk-prompt() {
    local CLR_DESK="%F{cyan}"
    [[ -z "$DESK_NAME" ]] && return 1
    print -nr -- "${CLR_DESK} ◲%f"
}

function _dotfiles-k8s-prompt() {
    local CLR_K8S_CLS="%F{blue}"
    local CLR_K8S_ENV="%F{blue}"

    local current_context
    current_context="$(kubectl config current-context 2>/dev/null)" || return 1
    [[ -z "$current_context" ]] && return 1

    print -nr -- "${CLR_K8S_CLS} (${CLR_K8S_ENV}${current_context}${CLR_K8S_CLS})%f"
}

PROMPT='$(_dotfiles-prompt)$(_dotfiles-virtualenv-prompt)$(_dotfiles-desk-prompt)$(_dotfiles-prompt2)'

RPROMPT=''
if command -v git >/dev/null 2>&1; then
    RPROMPT+='$(_dotfiles-git-prompt)'
fi
if [[ -n "$K8S_PROMPT" ]]; then
    RPROMPT+='$(_dotfiles-k8s-prompt)'
fi
