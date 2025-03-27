#!/usr/bin/bash
if ! command -v vim &> /dev/null; then
    echo -e "\033[0;31mVim is not installed!\033[0m"
    exit 1
fi
vim +PlugClean +PlugInstall +PlugUpdate +qall
