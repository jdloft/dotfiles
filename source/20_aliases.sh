# On Mac (Darwin), this should be `ls -G` if coreutils isn't installed from homebrew
if is_mac; then
    alias ls='ls -GF' # -G is colorized output, -F is to show trailing slashes and other file info
    alias n='open .'
    alias rm_quarantine='sudo xattr -r -d com.apple.quarantine'
    alias sha256sum='shasum -a 256'
elif is_bsd; then
    ls -G > /dev/null 2>&1 && alias ls='ls -GF' || alias ls='ls -F'
else
    alias ls='ls --color=auto'
    if is_wsl; then
        alias n='explorer.exe .'
    else
        alias n='(nohup nautilus -w . &) > /dev/null 2>&1'
    fi
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

alias nit='npm install && npm test'
alias jsonhint='jshint --extra-ext .json'
alias dsize='du -hs'
alias getip='curl -4 ifconfig.co; curl -6 ifconfig.co'

alias clean-win='find . -iname desktop.ini -delete' # honestly this shouldn't need to exist
alias clean-mac='find . -iname .DS_Store -delete' # this either; should do the weird underscore files too in the future

if which ack-grep > /dev/null 2>&1; then
    alias ack=ack-grep
fi

alias v="vim"
alias vd="vim \$(git diff --name-only --diff-filter=ACMR)"
alias vds="vim \$(git diff --staged --name-only --diff-filter=ACMR)"

alias st="git st"
alias staged="git diff --staged"

alias :q='exit'
alias :wq='exit'
alias :e='vim'

alias resetcomp='rm -f ~/.zcompdump; compinit'

# systemd
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='systemctl status'
alias s='systemctl'

alias sudo='sudo '
alias se=sudoedit

alias pm='podman'

# kubernetes
alias k='kubectl'

alias gpus="lspci -vnn | grep '\''[030[02]\]'"
alias x509="openssl x509 -noout -text -fingerprint -sha256 -in"

# use nvim if it exists
if type "nvim" > /dev/null 2>&1; then
    alias vim="nvim"
fi
