"-----------------------------------------------------------------------------
" Plug-ins
"

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'ekalinin/Dockerfile.vim'
" Plug 'ervandew/supertab'
Plug 'jdloft/vim-airline-themes'
Plug 'jdloft/vim-colors-solarized'
Plug 'justinmk/vim-sneak'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'wesQ3/vim-windowswap'
if v:version > 800
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
Plug 'easymotion/vim-easymotion'

call plug#end()
