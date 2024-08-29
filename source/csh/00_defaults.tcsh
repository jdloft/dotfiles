# Keyboard
bindkey -e
bindkey -k up history-search-backward
bindkey -k down history-search-forward
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "^[^H" backward-delete-word
