# Password generation
# Courtesy of @tstarling
function genpass() {
    tr -cd '[:alnum:]' < /dev/urandom | head -c15
    echo
}

# Open keys
function unlock-keys() {
    if [[ -e ~/.ssh/id_rsa || -e ~/.ssh/id_dsa ]]; then
        if [ -z "$SSH_AUTH_SOCK" ]; then
            eval `ssh-agent -s`
            ssh-add
        fi
    fi
}

# Tmux session
function go-session {
    tmux has-session -t $1 > /dev/null 2>&1
    if [ "$?" -eq 1 ]; then
        tmux new -s $1
    else
        tmux attach -t $1
    fi
}

# Yes no prompt
function yn-prompt {
    if [ "${SHELL##*/}" = "bash" ]; then
        read -p "Would you like to proceed? " -n 1 -r
    elif [ "${SHELL##*/}" = "zsh" ]; then
        read "REPLY?Would you like to proceed? "
    fi
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# OS detection

OSTYPE=$(uname -s)

function is_mac() {
    return `[[ "$OSTYPE" =~ ^darwin ]]`
}

# PATH manipulation
# http://stackoverflow.com/questions/370047/what-is-the-most-elegant-way-to-remove-a-path-from-the-path-variable-in-bash
path_append()  { path_remove $1; export PATH="$PATH:$1"; }
path_prepend() { path_remove $1; export PATH="$1:$PATH"; }
path_remove()  { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`; }
path_clean()   { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '!a[$1]++' | sed 's/:$//'`; }

title() {
    echo -ne "\033]0;$1\007"
}

# get messages from journalctl
msgs() {
    if [ -z "$1" ]; then
        journalctl -xef
    else
        journalctl -xefu $1
    fi
}

# new toolbox start
tb() {
    if [ -z "$1" ]; then
        toolbox enter
    else
        toolbox enter -c $1
    fi
}
