setopt PROMPT_SUBST
function _dotfiles-prompt() {
    local ec="$?"
    local host="$DOTFILES_HOST"
    local clr_user="$fg[cyan]"
    local clr_host="$fg[cyan]"
    local promptchar="\$"
    local supportcolor

    # Special cases
    if [ "$DOTFILES_HOST" = "hydrogen" ]; then
        clr_host="$fg[blue]"
    elif [ "$DOTFILES_HOST" = "titanium" ]; then
        clr_host="$fg[yellow]"
    elif [ "$DOTFILES_HOST" = "jdloft" ]; then
        host="neon"
        clr_host="$fg[green]"
    # WMF production like servers
    elif echo $DOTFILES_HOST | grep -q -E '\.wikimedia\.org|\.wmnet'; then
        clr_host="$fg[magenta]"
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
        clr_user="$fg[red]"
        promptchar="#"
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
    if [ "$labshost" = true ]; then
        echo "%{$reset_color%}[$(date +%H:%M\ %Z)] %{$clr_user%}\u%{$reset_color%} at \[$CLR_RED\]$host.\[$CLR_BOLD\]$project\[$CLR_NONE\]\[$CLR_RED\].\[$CLR_LINE\]$cluster\[$CLR_NONE\]\[$CLR_RED\].$site%{$reset_color%}${debian_chroot:+\[$CLR_YELLOW\] ($debian_chroot)\[$CLR_NONE\]} in \[$CLR_YELLOW\]\w\$(_dotfiles-git-prompt)\$(_dotfiles-virtualenv-prompt)\[$CLR_NONE\]\n$(_dotfiles-exit_code $ec)%{$reset_color%}$promptchar\[$CLR_NONE\] "
    else
        echo "%{$reset_color%}[$(date +%H:%M\ %Z)] $clr_user%n$reset_color at $clr_host$host$reset_color${debian_chroot:+$fg[yellow] ($debian_chroot)$reset_color} in $fg[yellow]${PWD/#$HOME/~}$(_dotfiles-git-prompt)$(_dotfiles-virtualenv-prompt)$reset_color
$(_dotfiles-exit_code)$promptchar$reset_color "
    fi
}

function _dotfiles-exit_code() {
    echo "%(?..$fg[red]%? )$reset_color"
}

# Git status
function _dotfiles-git-prompt() {
    local st_staged=0
    local st_unstaged=0
    local st_untracked=0
    local indicator
    local branch

    CLR_GITST_CLS="$fg[green]" # Clear state
    CLR_GITST_SC="$fg[yellow]" # Staged changes indicator
    CLR_GITST_USC="$fg[red]" # Unstaged changes indicator
    CLR_GITST_UT="$fg[cyan]" # Untracked files indicator
    CLR_GITST_BR="$fg[green]" # Branch

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
    echo -en "${CLR_GITST_CLS} (${CLR_GITST_BR}$branch$indicator${CLR_GITST_CLS})$reset_color"
}

function _dotfiles-virtualenv-prompt() {
    CLR_VE_CLS="$fg[yellow]"
    CLR_VE_ENV="$fg[yellow]"

    if [[ $VIRTUAL_ENV != "" ]]; then
        environment="${VIRTUAL_ENV##*/}"
    else
        return 1
    fi

    echo -en "${CLR_VE_CLS} (${CLR_VE_ENV}$environment${CLR_VE_CLS})$reset_color"
}

PROMPT='$(_dotfiles-prompt)'
