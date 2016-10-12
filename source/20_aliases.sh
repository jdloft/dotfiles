# On Mac (Darwin), this should be `ls -G` if coreutils isn't installed from homebrew
if [ is_mac ] && [[ `which ls` == '/bin/ls' ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

alias ll='ls -ahlF'
alias l='ll'
alias sl='ls'

alias df='df -h'

alias ..='cd ..'
alias ....='cd ../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'

alias mkdir='mkdir -p'

alias wget='wget -c'

alias grep='grep --color=auto'

alias parts='cat /proc/partitions'

alias nit='npm install && npm test'
alias jsonhint='jshint --extra-ext .json'
alias dsize='du -hs'
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

if which ack-grep > /dev/null 2>&1; then
    alias ack=ack-grep
fi

# SSH command opens keys, compiles config file, and starts
if [[ "${DOTFILES_LHOST##*.}" == "wmnet" || "${DOTFILES_LHOST##*.}" == "wmflabs" ]]; then
    if [ "${SHELL##*/}" = "bash" ]; then
        alias ssh='unlock-keys; cat ~/.ssh.d/!(40_wmf-proxy) > ~/.ssh/config; ssh'
    elif [ "${SHELL##*/}" = "zsh" ]; then
        alias ssh='unlock-keys; cat ~/.ssh.d/^*(40_wmf-proxy) > ~/.ssh/config; ssh'
    else
        echo "The WMF proxy SSH config exclusion was NOT set because the current shell ($SHELL) isn't configured in 20_aliases.sh!"
        alias ssh='unlock-keys; cat ~/.ssh.d/* > ~/.ssh/config; ssh'
    fi
else
    alias ssh='unlock-keys; cat ~/.ssh.d/* > ~/.ssh/config; ssh'
fi
