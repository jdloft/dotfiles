# Password generation
# Courtesy of @tstarling
function genpass() {
    tr -cd [:alnum:] < /dev/urandom | head -c10
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

# PATH manipulation
# http://stackoverflow.com/questions/370047/what-is-the-most-elegant-way-to-remove-a-path-from-the-path-variable-in-bash
path_append()  { path_remove $1; export PATH="$PATH:$1"; }
path_prepend() { path_remove $1; export PATH="$1:$PATH"; }
path_remove()  { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`; }
path_clean()   { export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '!a[$1]++' | sed 's/:$//'`; }
