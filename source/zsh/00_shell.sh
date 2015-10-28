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

[[ -n "${key[PageUp]}" ]] && bindkey "${key[PageUp]}" history-beginning-search-backward
[[ -n "${key[PageDown]}" ]] && bindkey "${key[PageDown]}" history-beginning-search-forward

#
# Colors
#

autoload -U colors
colors

#
# Misc
#

export EDITOR=vim

export GREP_OPTIONS='--color=auto'
