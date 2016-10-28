"-----------------------------------------------------------------------------
" Plug-ins
"
call plug#begin('~/.vim/plugged')

Plug 'Yggdroot/indentLine'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'edkolev/promptline.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ervandew/supertab'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

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
" theme set in color section
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
let g:airline_symbols.branch = '±'
let g:airline_symbols.paste = 'P'
let g:airline_symbols.whitespace = 'Ξ'

" tmuxline
if $NOTMUXLINE == ""
  let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '',
    \ 'right' : '',
    \ 'right_alt' : '',
    \ 'space' : ' '}

  let g:tmuxline_preset = {
    \ 'a': '#S',
    \ 'win': '#I: #W#F',
    \ 'cwin': '#I: #W#F',
    \ 'x': '%H:%M',
    \ 'y': '%a %d-%b-%y',
    \ 'z': '#h',
    \ 'options': {
      \ 'status-justify': 'left'}}
endif

" show buffers
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"-----------------------------------------------------------------------------
" Basic
"
set noshowmode
syntax enable
set encoding=utf-8

" remove insert delay
set timeoutlen=1000 ttimeoutlen=10

" mark trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" modeline
set modeline
let modelines=5

" easier to reach mapleader
let mapleader=","

" md files are markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" show incomplete commands
set showcmd

" tab autocompletion
set wildmode=longest,list
set wildmenu
set wildignore=*.o,*.out,*.obj,*.class
set wildignore+=*.swp,*~,._*
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=.git,.svn
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*/vendor/assets/**
set wildignore+=*/vendor/rails/**
set wildignore+=*/vendor/cache/**
set wildignore+=*/vendor/bundle/**
set wildignore+=*/vendor/submodules/**
set wildignore+=*/vendor/plugins/**
set wildignore+=*/vendor/gems/**
set wildignore+=*/.bundle/**
set wildignore+=*.gem
set wildignore+=*/log/**
set wildignore+=*/tmp/**
set wildignore+=*/_vendor/**

" colors
set background=dark

if $TERM == "xterm-256color"
  set t_Co=256
  colorscheme solarized
  let g:airline_theme = 'solarized'
  highlight CursorLineNr ctermfg=red

  function g:SolarizedFallback()
    let g:solarized_termcolors=256
    colorscheme solarized
  endfunction
  nnoremap <Leader>sf :call g:SolarizedFallback()<CR>
elseif $TERM == "screen-256color"
  set t_Co=256
  colorscheme solarized
  let g:airline_theme = 'solarized'
  highlight CursorLineNr ctermfg=red

  function g:SolarizedFallback()
    let g:solarized_termcolors=256
    colorscheme solarized
  endfunction
  nnoremap <Leader>sf :call g:SolarizedFallback()<CR>
else
  " TODO: should be replaced with a proper 8/16 bit theme
  let g:airline_theme = 'simple'
endif

"-----------------------------------------------------------------------------
" Execution commands
"
autocmd FileType python nmap <leader>ex :!python %<cr>
autocmd FileType ruby nmap <leader>ex :!ruby %<cr>
autocmd FileType cpp nmap <leader>ex :!g++ --std=c++11 -o %.out % && ./%.out && rm %.out<cr>

"-----------------------------------------------------------------------------
" Buffers
"
set hidden
nnoremap <Leader>gt :bn<CR>
nnoremap <Leader>gT :bp<CR>

"-----------------------------------------------------------------------------
" Scrolling
"
set scrolloff=5
set sidescrolloff=5
set sidescroll=1

"-----------------------------------------------------------------------------
" Searching
"
set hlsearch " highlight searches
set incsearch " incremental searching
set ignorecase " case insensitive search
set smartcase " except for one capital letter


"-----------------------------------------------------------------------------
" Numbering
"
set number
set relativenumber

" only show relative numbers in normal mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" don't show relative numbers when out of focus
au FocusLost * :set norelativenumber
au FocusGained * :set relativenumber

" fast toggling
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <Leader>n :call NumberToggle()<cr>

"-----------------------------------------------------------------------------
" Maps
"

" fast vimrc editing and sourcing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" wrapped lines nav
nnoremap k gk
nnoremap j gj

" common mis-types
nmap :W :w
nmap :Wq :wq
nmap :Q :q
nmap :Q! :q!
nmap :Dl :dl

" trailing whitespace removal
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" searching shortcuts
nnoremap <Leader>sh :set hlsearch!<CR>
nnoremap <Leader>cs :let @/ = ""<CR>
nnoremap <Leader>* :let curwd='\<<C-R>=expand("<cword>")<CR>\>'<CR>:let @/=curwd<CR>:call histadd("search", curwd)<CR>

" tmux navigator arrow key bindings
nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>

" paste mappings
nnoremap <leader>p :set paste!<cr>

" NERDTree shortcut
nnoremap <leader>ls :NERDTree<cr>

" Vim's hard mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
