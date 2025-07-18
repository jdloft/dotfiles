# Password generation
# Courtesy of @tstarling
function genpass() {
    LC_ALL=C tr -cd '[:alnum:]' < /dev/urandom | head -c15
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
    return `[[ "$OSTYPE" =~ ^Darwin ]]`
}

function is_bsd() {
    return `[[ "$OSTYPE" =~ BSD$ ]]`
}

function is_wsl() {
    return `[ ! -z "$WSLENV" ]`
}

# PATH manipulation
# http://stackoverflow.com/questions/370047/what-is-the-most-elegant-way-to-remove-a-path-from-the-path-variable-in-bash
path_append()  { export PATH="$PATH:$1"; }
path_prepend() { export PATH="$1:$PATH"; }
path_remove()  { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`; }
path_clean()   { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '!a[$1]++' | sed 's/:$//'`; }

title() {
    echo -ne "\033]0;$1\007"
}

adb-screenshot() {
    adb shell screencap -p | sed 's/^M$//' > "Screenshot from $(date '+%Y-%m-%d %H-%M-%S').png"
}

# test if we can read system journal
if journalctl --system -n 0 > /dev/null 2>&1; then
    # get messages from journalctl
    msgs() {
        if [ -z "$1" ]; then
            journalctl -xfn 25
        else
            journalctl -xfu $1 -n 25
        fi
    }

    j() {
        if [ -z "$1" ]; then
            journalctl -xe
        else
            journalctl -xeu $1
        fi
    }
else
    msgs() {
        if [ -z "$1" ]; then
            sudo journalctl -xfn 25
        else
            sudo journalctl -xfu $1 -n 25
        fi
    }

    j() {
        if [ -z "$1" ]; then
            sudo journalctl -xe
        else
            sudo journalctl -xeu $1
        fi
    }
fi

# add to git exclude
exclude() {
    if [ -z "$1" ]; then
        echo "This requires a file or pattern argument"
    else
        echo $1 >> ./.git/info/exclude
    fi
}

# color test
# see also bin/termcolors
# https://unix.stackexchange.com/questions/308094/print-a-256-color-test-pattern-in-the-terminal
color_test() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}m%3d " "${i}"
        if (( $i == 15 )) || (( $i > 15 )) && (( ($i-15) % 12 == 0 )); then
            echo;
        fi
    done

    T='gYw'   # The test text

    printf "\n         def     40m     41m     42m     43m     44m     45m     46m     47m\n";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m';

      do FG=${FGs// /}
      printf " $FGs \033[$FG  $T  "

      for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do printf "$EINS \033[$FG\033[$BG  $T  \033[0m";
      done
      echo;
    done
    echo
}

listen() {
    if [ -f $1 ]; then
        tail -f $1 | grep --line-buffered $2
    else
        echo "Please specify a file"
    fi
}

function sudoedit() {
    SUDO_COMMAND="sudoedit $@" command sudoedit "$@"
}

function x509remote() {
    echo | openssl s_client -connect $1 -showcerts | openssl x509 -text -noout -fingerprint -sha256
}

function x509remoteall() {
    temp=$(mktemp)
    echo | openssl s_client -connect $1 -showcerts 2>/dev/null > $temp
    openssl crl2pkcs7 -nocrl -certfile $temp | openssl pkcs7 -print_certs -text -noout
    rm $temp
}

if ! is_mac; then
    function hasopen() {
        pids=`ls -l /proc/[0-9]*/fd/* 2>/dev/null | grep $1 | grep -oP '/proc/(\d+)/fd/' | grep -oP '\d+'`
        while IFS= read -r pid; do
            if [ -d /proc/$pid ]; then
                comm=`cat /proc/$pid/cmdline`
                echo "$pid: $comm"
            else
                echo "$pid"
            fi
        done <<< $pids
    }
fi

# https://unix.stackexchange.com/a/253369
function rescueterm() {
    stty sane
    printf '\033k%s\033\\\033]2;%s\007' "$(basename "$SHELL")" "$(uname -n)"
    tput reset
    tmux refresh
    echo "Run \"set-window-option automatic-rename on\" in tmux"
}

merge_kubeconfigs() {
    local kubeconfig="$HOME/.kube/config"
    local backup="$HOME/.kube/config-backup"
    local tmpfile
    local file1 file2

    if [ "$#" -eq 1 ]; then
        file1="$kubeconfig"
        file2="$1"
    elif [ "$#" -eq 2 ]; then
        file1="$1"
        file2="$2"
    else
        echo "Usage:"
        echo "  merge_kubeconfigs <file>"           # merge ~/.kube/config with <file>
        echo "  merge_kubeconfigs <file1> <file2>" # merge <file1> and <file2>"
        return 1
    fi

    # Check files exist
    for f in "$file1" "$file2"; do
        if [ ! -f "$f" ]; then
            echo "Error: file not found: $f" >&2
            return 1
        fi
    done

    # Backup ~/.kube/config
    if [ -f "$kubeconfig" ]; then
        cp "$kubeconfig" "$backup"
        chmod 600 "$backup"
        echo "Backed up $kubeconfig to $backup"
    fi

    # Create a temp file
    tmpfile=$(mktemp)
    chmod 600 "$tmpfile"

    # Merge configs into temp file
    if KUBECONFIG="$file1:$file2" kubectl config view --merge --flatten > "$tmpfile"; then
        mv "$tmpfile" "$kubeconfig"
        echo "Merged kubeconfig saved to $kubeconfig"
    else
        echo "Failed to merge kubeconfigs" >&2
        rm -f "$tmpfile"
        return 1
    fi
}
