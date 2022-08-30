# Prompt
autoload -U promptinit compinit compdef # autoload prompt and completion
promptinit

setopt autocd

# History
export HISTSIZE=1000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
export SHELL_SESSION_HISTORY=0 # disable new sessions in macOS

setopt PROMPT_SUBST

setopt extended_glob

# Colors
autoload -U colors
colors

# Misc
export EDITOR=vim

export VIRTUAL_ENV_DISABLE_PROMPT=1

# Cache
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR/completions"
