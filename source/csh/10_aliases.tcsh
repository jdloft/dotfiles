set os_type=`uname -s`

if ( $os_type =~ '^Darwin' ) then
  alias ls ls -GF
  alias n open .
  alias rm_quarantine sudo xattr -r -d com.apple.quarantine
  alias sha256sum shasum -a 256
else if ( $os_type =~ 'BSD$' ) then
  ls -G >& /dev/null
  if ( $? == 0 ) then
    alias ls ls -GF
  else
    alias ls ls -F
  endif
else
  if ($?WSLENV) then
    alias n explorer.exe .
  else
    alias n '(nohup nautilus -w . &) >& /dev/null'
  endif
  alias ls ls --color=auto
endif

alias ll ls -ahlF
alias l ll
alias sl ls
alias df df -h

alias .. cd ..
alias .... cd ../..
alias .2 cd ../..
alias .3 cd ../../..
alias .4 cd ../../../..
alias .5 cd ../../../../..
alias .6 cd ../../../../../..

alias mkdir mkdir -p
alias wget wget -c
alias grep grep --color=auto

alias v vim
alias vd 'vim `git diff --name-only --diff-filter=ACMR`'
alias vds 'vim `git diff --staged --name-only --diff-filter=ACMR`'

alias st git st
alias staged git diff --staged

alias :q exit
alias :wq exit
alias :e vim

# systemd
alias start sudo systemctl start
alias stop sudo systemctl stop
alias restart sudo systemctl restart
alias status systemctl status
alias s systemctl

alias se sudoedit

alias pm podman

# kubernetes
alias k kubectl

alias x509 openssl x509 -noout -text -in
