"-----------------------------------------------------------------------------
" Plug-ins
"
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'edkolev/tmuxline.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ervandew/supertab'
Plug 'jdloft/vim-airline-themes'
Plug 'jdloft/vim-y86-syntax'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'wesQ3/vim-windowswap'

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
let g:airline#extensions#hunks#enabled = 0


" ALE
let g:ale_echo_msg_format = '%linter%: %s'

let g:ale_linters = {
  \ 'cpp': ['gcc']
\}

let g:ale_type_map = {
  \ 'flake8': {'ES': 'WS'}
\}


" vim-commentary
autocmd FileType c setlocal commentstring=//\ %s


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
    \ 'space' : ' '
  \}

  let g:tmuxline_preset = {
    \ 'a': '#S',
    \ 'win': '#I: #W#F',
    \ 'cwin': '#I: #W#F',
    \ 'x': '%H:%M',
    \ 'y': '%a %d-%b-%y',
    \ 'z': '#h',
    \ 'options': {
      \ 'status-justify': 'left'
    \}
  \}
endif

" show buffers
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" show ALE loc list
" let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1

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

if $TERM == "xterm-256color" || $TERM == "screen-256color"
  set t_Co=256
  colorscheme solarized
  let g:airline_theme = 'solarized'
  let g:airline_solarized_normal_blue = 1
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
autocmd FileType cpp nmap <leader>ex :!g++ --std=c++11 -Wall -Werror -o %.out % && ./%.out; rm %.out<cr>
autocmd FileType c nmap<leader>ex :!gcc -Wall -Werror -o %.out % && ./%.out; rm %.out<cr>

"-----------------------------------------------------------------------------
" Buffers
"
set hidden
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>F :bp<CR>
nnoremap <Leader><Tab> :b#<CR>

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
nnoremap <Leader>n :set relativenumber!<cr>

"-----------------------------------------------------------------------------
" Tabbing
" should be set by vim-sleuth
"
set expandtab
set shiftwidth=4
set softtabstop=4

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

" trailing whitespace removal
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" searching shortcuts
nnoremap <Leader>sh :set hlsearch!<CR>
nnoremap <Leader>cs :nohlsearch<CR>

" tmux navigator arrow key bindings
nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>

" paste mappings
nnoremap <leader>p :set paste!<cr>

" NERDTree shortcut
nnoremap <leader>ls :NERDTree<cr>

" Words cannot describe the evil-ness of this command
map q: <Nop>

" Insert single character
nnoremap <Space> i_<Esc>r
