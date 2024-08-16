#!/bin/sh
find $DOTFILES -iname "*.pyc" -delete
find $DOTFILES -iname "*.png" -delete
find $DOTFILES -iname "*.gif" -delete
echo "Review:"
find $DOTFILES -type f | xargs file | grep -Ev "ASCII text|VAX COFF|Git pack|Git index|Unicode text|empty"
