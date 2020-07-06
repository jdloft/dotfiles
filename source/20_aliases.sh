# On Mac (Darwin), this should be `ls -G` if coreutils isn't installed from homebrew
if is_mac && [[ `which ls` == '/bin/ls' ]]; then
    alias ls='ls -GF' # -G is colorized output, -F is to show trailing slashes and other file info
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

alias d='desk go'
alias mkdir='mkdir -p'
alias wget='wget -c'
alias grep='grep --color=auto'
alias parts='cat /proc/partitions'
alias n='(nohup nautilus -w . &) > /dev/null 2>&1'

alias nit='npm install && npm test'
alias jsonhint='jshint --extra-ext .json'
alias dsize='du -hs'
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

alias fix-perms='chmod -R u+rwX,go+rX,go-w' # dir rwxr-xr-x, files rw-r--r--
alias clean-win='find . -iname desktop.ini -delete' # honestly this shouldn't need to exist
alias clean-mac='find . -iname .DS_Store -delete' # this either; should do the weird underscore files too in the future

if which ack-grep > /dev/null 2>&1; then
    alias ack=ack-grep
fi

alias v="vim"
alias vd="vim \$(git diff HEAD --name-only --diff-filter=ACMR)"
alias vds="vim \$(git diff --staged --name-only --diff-filter=ACMR)"
alias vdc="vim \$(git diff HEAD^ --name-only --diff-filter=ACMR)"
alias vdm="vim \$(git diff master --name-only --diff-filter=ACMR)"

alias stage="git diff --staged"

alias :q='exit'
alias :wq='exit'
alias :e='vim'

alias resetcomp='rm -f ~/.zcompdump; compinit'

# systemd
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='systemctl status'

alias se=sudoedit

# New Silverblue aliases
alias pm='podman'

# kubernetes
alias k='kubectl'
