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

setopt PROMPT_SUBST

if [[ -n "${terminfo[kpp]}" && -n "${terminfo[knp]}" ]]; then
    bindkey "${terminfo[kpp]}" history-beginning-search-backward
    bindkey "${terminfo[knp]}" history-beginning-search-forward
fi

setopt extended_glob

# Colors
autoload -U colors
colors

# Misc
export EDITOR=vim

export VIRTUAL_ENV_DISABLE_PROMPT=1
