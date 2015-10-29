#!/usr/bin/zsh

# Prompt
autoload -U promptinit compinit # autoload prompt and completion
promptinit

# Completion
compinit
zstyle ':completion:*' menu select # fancy tab completion menu
setopt completealiases

setopt autocd

# History
export HISTSIZE=1000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

setopt PROMPT_SUBST

path=(~/bin $path[@])

if [[ -n "${key[PageUp]}" && -n "${key[PageDown]}" ]]; then
    bindkey "${key[PageUp]}" history-beginning-search-backward
    bindkey "${key[PageDown]}" history-beginning-search-forward
fi

#
# Colors
#

export TERM=screen-256color
autoload -U colors
colors

#
# Misc
#

export EDITOR=vim

export GREP_OPTIONS='--color=auto'
