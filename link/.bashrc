# Where the magic happens.
export DOTFILES=~/.dotfiles

# Source all files in "source"
function src() {
  local file
  if [ -f "$HOME/.bashrc.pre" ]; then
    source "$HOME/.bashrc.pre"
  fi
  for file in $DOTFILES/source/*; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done
  for file in $DOTFILES/source/bash/*; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done
  if [ -f "$HOME/.bashrc.post" ]; then
    source "$HOME/.bashrc.post"
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}

src
