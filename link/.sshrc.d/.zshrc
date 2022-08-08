export DOTFILES="$SSHHOME/.sshrc.d"
function src() {
  local file
  for file in $SSHHOME/.sshrc.d/*.sh; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done
  if [ -n "$ZSH_VERSION" ]; then
    for file in $SSHHOME/.sshrc.d/zsh/*; do
        if [[ -f "$file" ]]; then
            source "$file"
        fi
    done
  elif [ -n "$BASH_VERSION" ]; then
    for file in $SSHHOME/.sshrc.d/bash/*; do
      if [ -f "$file" ]; then
        source "$file"
      fi
    done
  else
    echo "Unknown shell; doing nothing"
  fi
}
function dotfiles() {
  echo "We're running in sshrc mode"
  exit 1
}
src
