" vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'puppetlabs/puppet-syntax-vim'
Plug 'arnar/vim-matchopen'
Plug 'scrooloose/syntastic'

call plug#end()

" mark trailing whitespace
match ErrorMsg '\s\+$'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
