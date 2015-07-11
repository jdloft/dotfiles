" vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'puppetlabs/puppet-syntax-vim'
Plug 'arnar/vim-matchopen'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'

call plug#end()

" mark trailing whitespace
match ErrorMsg '\s\+$'

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_error_symbol = "!!"
let g:syntastic_style_error_symbol = "S!"
let g:syntastic_warning_symbol = ">>"
let g:syntastic_style_warning_symbol = "S>"

" vim-airline
set laststatus=2
let g:airline_theme = 'simple'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

" poor man's solution to no patched fonts
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  " let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  " let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'P'
  " let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
