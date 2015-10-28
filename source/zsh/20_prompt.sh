function _dotfiles-prompt() {
    local host="$DOTFILES_HOST"
    local clr_user="%F{cyan}"
    local clr_host="%F{cyan}"
    local promptchar="\$"

    # Special cases
    if [ "$DOTFILES_HOST" = "hydrogen" ]; then
        clr_host="%F{blue}"
    elif [ "$DOTFILES_HOST" = "titanium" ]; then
        clr_host="%F{yellow}"
    elif [ "$DOTFILES_HOST" = "jdloft" ]; then
        host="neon"
        clr_host="%F{green}"
    # WMF production like servers
    elif echo $DOTFILES_HOST | grep -q -E '\.wikimedia\.org|\.wmnet'; then
        clr_host="%F{magenta}"
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
        clr_user="%F{red}"
        promptchar="#"
    fi

    # Chroot info
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # Actual prompt code
    if [ "$labshost" = true ]; then
        echo "%f[$(date +%H:%M\ %Z)] $clr_user%n%f at %F{red}$host.%B$project%b%F{red}.%U$cluster%u%F{red}.$site%f${debian_chroot:+"%F{yellow} ($debian_chroot)%f"} in %F{yellow}${PWD/#$HOME/~}%f\n$(_dotfiles-exit_code)$promptchar%f "
    else
        echo "%f[$(date +%H:%M\ %Z)] $clr_user%n%f at $clr_host$host%f${debian_chroot:+"%F{yellow} ($debian_chroot)%f"} in %F{yellow}${PWD/#$HOME/~}%f\n$(_dotfiles-exit_code)$promptchar%f "
    fi
}

function _dotfiles-exit_code() {
    echo "%(?..%F{red}%?%f )"
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

PROMPT='$(_dotfiles-prompt)'
RPROMPT='$(_dotfiles-git-prompt)$(_dotfiles-virtualenv-prompt)'
