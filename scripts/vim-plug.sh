#!/usr/bin/env sh
if ! command -v vim &> /dev/null; then
    echo -e "\033[0;31mVim is not installed!\033[0m"
    exit 1
fi
vim -u ~/.vim/vim-plugged.vim +PlugClean +PlugInstall +PlugUpdate +qall
