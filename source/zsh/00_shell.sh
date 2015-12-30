#!/usr/bin/zsh

# Prompt
autoload -U promptinit compinit compdef # autoload prompt and completion
promptinit

# Completion
compinit
zstyle ':completion:*' menu select # fancy tab completion menu
setopt completealiases

setopt autocd

export LANG="en_US.UTF-8"

# History
export HISTSIZE=1000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

setopt PROMPT_SUBST

if [[ -n "${key[PageUp]}" && -n "${key[PageDown]}" ]]; then
    bindkey "${key[PageUp]}" history-beginning-search-backward
    bindkey "${key[PageDown]}" history-beginning-search-forward
fi

setopt extended_glob

#
# Colors
#

export TERM=xterm-256color
autoload -U colors
colors

#
# Misc
#

export EDITOR=vim

export VIRTUAL_ENV_DISABLE_PROMPT=1
