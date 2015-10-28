# Ubuntu (Linux), Solaris (SunOS)
# On Mac (Darwin), this should be `ls -G`. However coreutils is installed
# from Homebrew, so 'which ls' != '/bin/ls' on Mac.
alias ls='ls --color=auto'

alias ll='ls -ahlF'
alias l='ll'

alias df='df -h'

alias ..='cd ..'
alias ....='cd ../../'
alias ......='cd ../../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias -- -='cd -'

alias mkdir='mkdir -p'

alias wget='wget -c'

alias parts='cat /proc/partitions'

alias nit='npm install && npm test'
alias jsonhint='jshint --extra-ext .json'
alias dsize='du -hs'
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

if which ack-grep > /dev/null 2>&1; then
    alias ack=ack-grep
fi

# SSH command opens keys, compiles config file, and starts
alias ssh='unlock-keys; cat ~/.ssh.d/* > ~/.ssh/config; ssh'
