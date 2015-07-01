" vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'puppetlabs/puppet-syntax-vim'
Plug 'arnar/vim-matchopen'

call plug#end()

" mark trailing whitespace
match ErrorMsg '\s\+$'
