# Where the magic happens.
export DOTFILES=~/.dotfiles

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

# Source all files in "source"
function src() {
  local file
  for file in $DOTFILES/source/bash/*; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done
  for file in $DOTFILES/source/*; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done
}

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}

src
