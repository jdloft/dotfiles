#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Preflight
if [ -z "$SKIP_PREFLIGHT" ]; then
  if [ ! -d "$DOTFILES/link/.vim/plugged" ]; then
    echo -e "${RED}Vim plugins not installed. Run $DOTFILES/scripts/vim-plug.sh first$NC"
    exit 1
  else
    echo -e "${GREEN}Vim plugins found$NC"
  fi

  if [ ! -d "$DOTFILES/link/.tmux/plugins/tmux-continuum" ]; then
    echo -e "${RED}Tmux plugins not installed. Run ~/.tmux/plugins/tpm/bin/install_plugins first$NC"
    exit 1
  else
    echo -e "${GREEN}Tmux plugins found$NC"
  fi
fi

touch $DOTFILES/offline
tar czvf ~/dotfiles.tar.gz --exclude .DS_Store -C $HOME ${DOTFILES/#$HOME\//}
rm $DOTFILES/offline
