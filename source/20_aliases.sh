# On Mac (Darwin), this should be `ls -G` if coreutils isn't installed from homebrew
if [[ is_mac == 0 ]] && [[ `which ls` == '/bin/ls' ]]; then
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

alias v="vim"
alias vd="vim \$(git diff HEAD --name-only --diff-filter=ACMR)"
alias vds="vim \$(git diff --staged --name-only --diff-filter=ACMR)"
alias vdc="vim \$(git diff HEAD^ --name-only --diff-filter=ACMR)"
alias vdm="vim \$(git diff master --name-only --diff-filter=ACMR)"
