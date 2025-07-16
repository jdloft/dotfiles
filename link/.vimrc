"-----------------------------------------------------------------------------
" Plug-ins
"

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator', {'commit': 'd847ea9'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale', {'tag': 'v3.3.x'}
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ervandew/supertab', {'tag': '2.1'}
Plug '~/.vim/plugged/vim-airline-themes'
Plug '~/.vim/plugged/vim-colors-solarized'
Plug 'justinmk/vim-sneak'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sleuth'
Plug 'wesQ3/vim-windowswap'

call plug#end()

" https://vi.stackexchange.com/a/14143
function! PlugLoaded(name)
  let l:dir_stripped = substitute(g:plugs[a:name].dir, '^\(.*\)/$', '\1', '')
  return (
    \ has_key(g:plugs, a:name) &&
    \ isdirectory(g:plugs[a:name].dir) &&
    \ stridx(&rtp, l:dir_stripped) >= 0)
endfunction


" vim-airline
set laststatus=2
" theme set in color section
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#hunks#enabled = 0

" poor man's solution to no patched fonts
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' '
let g:airline_symbols.branch = '±'
let g:airline_symbols.paste = 'P'
let g:airline_symbols.whitespace = 'Ξ'

" show buffers
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" ALE
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 2000
" let g:ale_open_list = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_use_ch_sendraw = 1
let g:ale_completion_enabled = 1

let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'cpp': ['clangd', 'cc']
\}

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['eslint'],
\}

let g:ale_type_map = {
  \ 'flake8': {'ES': 'WS'}
\}

" Hopefully pylint resolves any errors with star
" F403 = unable to detect undefined names
" F405 = may have been imported via star
let g:ale_python_flake8_options = '--ignore=F403,F405,E'
let g:ale_python_pylint_options = '--disable=C0103,C' " C0103 = constant doesn't conform to UPPERCASE

" signs
let g:ale_sign_error = '!>'
let g:ale_sign_style_error = 'S!'
let g:ale_sign_warning = '>>'
let g:ale_sign_style_warning = 'S'
let g:ale_sign_info = '->'

nnoremap <silent> K :ALEHover<CR>


" vim-commentary
autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType cpp setlocal commentstring=//\ %s


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

"-----------------------------------------------------------------------------
" Basic
"
set noshowmode
syntax enable
set encoding=utf-8
set backspace=indent,eol,start
set nofoldenable

" set directory=~/.cache//

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
set wildmode=longest,list,full
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
if !empty($SOLAR_LIGHT) && $SOLAR_LIGHT == 'true'
  set background=light
else
  set background=dark
endif

if $TERM =~# '256color\|ghostty'
  set t_Co=256
endif

" Solar modes:
" NO_SOLAR = no solar colors at all, use solarized fallback
" 1 = solar colors
" 2 = solar colors, transparent terminal (don't override background)
" 3 = modified solar colors (upper solar colors are in colors 16-21)
if $SOLAR_MODE ==# 'none'
  " Fallback solarized palette
  let g:solarized_termcolors=256
else
  if $SOLAR_MODE ==# 'mode3'
    let g:solarized_mode3 = 1
  elseif $SOLAR_MODE ==# 'mode2'
    let g:solarized_termtrans = 1
  endif
endif

let g:airline_theme = 'solarized'
let g:airline_solarized_normal_blue = 1
let g:airline_solarized_enable_command_color = 1
let g:airline_solarized_dark_inactive_border = 1

if PlugLoaded('vim-colors-solarized')
  colorscheme solarized
  call togglebg#map("<F5>")
endif

highlight CursorLineNr         ctermbg=black ctermfg=red
highlight SignColumn           guibg=black  ctermbg=black
highlight GitGutterAdd         guibg=black  ctermbg=black guifg=green  ctermfg=green
highlight GitGutterChange      guibg=black  ctermbg=black guifg=yellow ctermfg=yellow
highlight GitGutterDelete      guibg=black  ctermbg=black guifg=red    ctermfg=red
highlight ALEErrorSign         ctermbg=black ctermfg=red
highlight ALEWarningSign       ctermbg=black ctermfg=yellow
highlight ALEStyleErrorSign    ctermbg=black ctermfg=grey
highlight ALEStyleWarningSign  ctermbg=black ctermfg=grey

highlight link ALEVirtualTextError Error
highlight ALEVirtualTextWarning ctermfg=yellow
highlight link ALEVirtualTextInfo Comment


" highligh TEMP
syntax match cTodo /TEMP/ containedin=.*Comment

" detect filetype depending on SUDO_COMMAND with sudoedit
" from tpope/vim-eunuch
if (!empty($SUDO_COMMAND))
  let files = split($SUDO_COMMAND, ' ')[1:-1]
  if len(files) ==# argc()
    for i in range(argc())
      execute 'autocmd BufEnter' fnameescape(argv(i))
        \ 'if &filetype ==# "" |'
        \ 'doautocmd filetypedetect BufReadPost ' . fnameescape(files[i])
    endfor
  endif
endif

" mouse
" set ttymouse=xterm2
" set mouse=a

" clipboard
" disable X11 clipboard if in SSH
" NOTE: now handled in 20_aliases.sh
" if $SSH_CONNECTION
"   set clipboard=exclude:.*
" endif

" Ctrl-P
let g:ctrlp_follow_symlinks = 1

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
nnoremap <Leader>d :bp\|bd #<CR>
nnoremap gb :buffer<Space>

"-----------------------------------------------------------------------------
" Scrolling
"
set scrolloff=5
set sidescrolloff=5
set sidescroll=1

"-----------------------------------------------------------------------------
" Speed
"
set synmaxcol=500
if !has('nvim')
  set ttyfast
  set ttyscroll=3
endif
set lazyredraw

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
nnoremap <Leader>rn :set relativenumber!<cr>
nnoremap <Leader>n :set number!<cr>

" Copy mode hides sign column and numbers
let s:copymode = 0
function! ToggleCopyMode()
  if s:copymode
    set number
    set signcolumn=auto
    let s:copymode = 0
  else
    set nonumber
    set signcolumn=no
    let s:copymode = 1
  endif
endfunction
nnoremap <Leader>cp :call ToggleCopyMode()<cr>
vnoremap <C-c> "*y

"-----------------------------------------------------------------------------
" Tabbing
" should be set by vim-sleuth, this is just default
"
set expandtab
set shiftwidth=4
set softtabstop=4

" Autocomplete
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-p>"

"-----------------------------------------------------------------------------
" Maps
"

" fast vimrc editing and sourcing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" similar to tmux
set splitright
set splitbelow

" wrapped lines nav
" nnoremap k gk
" nnoremap j gj
set nowrap
set linebreak

" common mis-types
command! -bang W w<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Q q<bang>

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
nnoremap <Leader>p :set paste!<cr>:set number!<cr>

" replace without yanking
vnoremap p "_dP

" don't copy on clear
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C

" system clipboard
vnoremap <C-c> "*y

" NERDTree shortcut
nnoremap <leader>ls :NERDTree<cr>

" Words cannot describe the evil-ness of this command
map q: <Nop>

" Insert single character
" nnoremap <Space> i_<Esc>r

syntax match TempKeyword /\<TEMP\>/
highlight link TempKeyword Todo
