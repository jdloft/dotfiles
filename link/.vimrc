" Plug-ins
" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'puppetlabs/puppet-syntax-vim'
Plug 'arnar/vim-matchopen'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-sleuth'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'scrooloose/nerdtree'

call plug#end()


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

let g:syntastic_python_flake8_args = "--ignore=E501"

" vim-airline
set laststatus=2
let g:airline_theme = 'simple'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

" poor man's solution to no patched fonts
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
let g:airline_right_sep = ''
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'P'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


" Configs
" mark trailing whitespace
match ErrorMsg '\s\+$'

" line numbering
set number

" fast out of insert
set timeoutlen=1000 ttimeoutlen=10

" don't show mode, vim-airline does it
set noshowmode

" modeline
set modeline
let modelines=5

" Execution commands
autocmd FileType python nmap <leader>ex :!python %<cr>
autocmd FileType ruby nmap <leader>ex :!ruby %<cr>

" Maps
let mapleader=","

" fast vimrc editing and sourcing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" wrapped lines nav
nnoremap k gk
nnoremap j gj

" Common mis-types
nmap :W :w
nmap :Wq :wq
nmap :Q :q
nmap :Q! :q!
nmap :Dl :dl

" trailing whitespace removal
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" tmux navigator arrow key bindings
nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>

" paste mappings
nnoremap <leader>p :set paste!<cr>

" NERDTree shortcut
nnoremap <leader>sf :NERDTree<cr>

" Vim. Live it.
" https://tylercipriani.com/vim.html
inoremap <up> <nop>
vnoremap <up> <nop>
inoremap <down> <nop>
vnoremap <down> <nop>
inoremap <left> <nop>
vnoremap <right> <nop>
vnoremap <left> <nop>
inoremap <right> <nop>
" B-A-<start>
