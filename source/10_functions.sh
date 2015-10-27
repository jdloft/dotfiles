# Password generation
# Courtesy of @tstarling
function genpass() {
    tr -cd [:alnum:] < /dev/urandom | head -c10
    echo
}

# Open keys
function open-keys() {
    if [[ -e ~/.ssh/id_rsa || -e ~/.ssh/id_dsa ]]; then
        if [ -z "$SSH_AUTH_SOCK" ]; then
            eval `ssh-agent -s`
            ssh-add
        fi
    fi
}
