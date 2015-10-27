#!/usr/bin/zsh

autoload -U promptinit compinit # autoload prompt and completion
promptinit

compinit
zstyle ':completion:*' menu select # fancy tab completion menu
setopt completealiases

setopt HIST_IGNORE_DUPS

path=(~/bin $path[@])

[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward # command searching (from Arch wiki)
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# Colors!
autoload -U colors
colors
