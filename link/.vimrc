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
Plug 'jdloft/vim-airline-themes'
Plug 'jdloft/vim-colors-solarized'
Plug 'justinmk/vim-sneak'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'wesQ3/vim-windowswap'
if v:version > 800
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()

" https://vi.stackexchange.com/a/14143
function! PlugLoaded(name)
  return (
    \ has_key(g:plugs, a:name) &&
    \ isdirectory(g:plugs[a:name].dir))
endfunction


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


" ALE (fallback for CoC)
let g:ale_echo_msg_format = '%linter%: %s'

let g:ale_linters = {
  \ 'cpp': ['gcc']
\}

let g:ale_type_map = {
  \ 'flake8': {'ES': 'WS'}
\}

" CoC startup
let g:coc_start_at_startup=0

" vim-commentary
autocmd FileType c setlocal commentstring=//\ %s


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
set backspace=indent,eol,start

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
if $SOLAR_LIGHT == "true"
  set background=light
else
  set background=dark
endif

if $TERM == "xterm-256color" || $TERM == "screen-256color"
  set t_Co=256
  " TODO: test some gui fg and bgs? idk I don't really care about gui
  highlight CursorLineNr ctermbg=black ctermfg=red
  highlight LineNr       ctermbg=black ctermfg=8

  if $NO_SOLAR == "true"
    " Fallback solarized palette
    let g:solarized_termcolors=256
    let g:airline_theme = 'simple'
  else
    let g:airline_theme = 'solarized'
    let g:airline_solarized_normal_blue = 1
    let airline_solarized_enable_command_color = 1
    let g:airline_solarized_dark_inactive_border = 1

    if $SOLAR_MODE3 == "true"
      let g:solarized_mode3 = 1
    elseif $SOLAR_MODE2 == "true"
      let g:solarized_termtrans = 1
    endif
  endif

  if PlugLoaded('vim-colors-solarized')
    colorscheme solarized
  endif
else
  " TODO: should be replaced with a proper 8/16 bit theme
  let g:airline_theme = 'simple'
endif

highlight SignColumn      guibg=black ctermbg=black
highlight GitGutterAdd    guibg=black ctermbg=black guifg=green ctermfg=green
highlight GitGutterChange guibg=black ctermbg=black guifg=yellow ctermfg=yellow
highlight GitGutterDelete guibg=black ctermbg=black guifg=red ctermfg=red

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

"-----------------------------------------------------------------------------
" Tabbing
" should be set by vim-sleuth, this is just default
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

"-----------------------------------------------------------------------------
" CoC stuff
"

if v:version > 800 && PlugLoaded('coc.nvim') && executable('node')
  let g:ale_enabled=0
  call coc#rpc#start_server()

  command InstallCocServers
        \ exe ':CocInstall coc-pyright' |
        \ exe ':CocInstall coc-sh' |
        \ exe ':CocInstall coc-clangd'
        " TODO: Install something for Dockerfiles

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: There's always complete item selected by default, you may want to enable
  " no select by `"suggest.noselect": true` in your configuration file.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>cf  <Plug>(coc-format-selected)
  nmap <leader>cf  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Run the Code Lens action on the current line.
  nmap <leader>cl  <Plug>(coc-codelens-action)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocActionAsync('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
endif
let g:coc_disable_startup_warning = 1
