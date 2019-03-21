set nocompatible        " Ignore backward compat

" Display
colorscheme torte
syntax on               " use syntax hilighting
set noerrorbells
set nolazyredraw        " don't redraw while executing macros
set nolist              " don't show invisible chars
set novisualbell
set nowrap              " don't wrap lines
set number              " number lines for reference
set ruler               " always show cursor position
set shortmess=atToO     " avoid annoying prompts
set fillchars+=vert:│
set listchars=eol:¬,tab:▸\ ,trail:•,extends:❯,precedes:❮
set showbreak=↪\
set showcmd             " show partial commands on status line
set showmatch           " show matching brackets/parenthesis
set showmode            " show what mode we're in
set termguicolors       " enable true color

" Search
set hlsearch            " highlight search terms
set ignorecase          " case insensitive search
set incsearch           " find as you type search
set smartcase           " case sensitive if uppercase

" Editing
set autoindent                 " carry indent to new-lines
set expandtab                  " tab expands to spaces
set backspace=indent,eol,start " backspace over everything
set smarttab                   " insert blanks according to sw, ts, sts
set shiftwidth=2               " spaces per indent
set tabstop=2                  " spaces per tab in display
set softtabstop=2              " spaces per tab when inserting
set smartindent                " be smart about auto-indents and disable on #
set foldmethod=syntax          " folds are defined by syntax
set foldlevel=99               " keep folds open to max
:inoremap # X#

" Interface
set mouse=a         " mouse enabled for all modes
set splitright
set splitbelow
set scrolloff=5     " when moving outside viewport, give more context
set sidescroll=5    " keep columns in context
set matchtime=2     " how long to highlight the matching paren
set notimeout       " don't timeout on incomplete key-mappings


" Misc
set modelines=0               " ignore file-specific configs in headers
set clipboard=unnamedplus     " use system clipboard
set wildignore+=*.o,*~,*.so,.svn,CVS,.git,*.a,*.class,*.obj,*.la,*.swp

" Key Mappings
let mapleader = "\<Space>"
let maplocalleader = ","

" Map <C-g> to escape the terminal
tnoremap <C-g> <C-\><C-n>
" Map to escape insert mode
inoremap jk <ESC>
" Switch to directory of current file
nnoremap <silent> <leader>cd :cd %:h<CR>

" Toggle features
nnoremap <silent> <leader>tp :set invpaste<CR>
nnoremap <silent> <leader>tc :set invcursorline invcursorcolumn<CR>
nnoremap <silent> <leader>ts :set invspell<CR>
nnoremap <silent> <leader>tn :set invnumber<CR>
nnoremap <silent> <leader><CR> :nohlsearch<CR>

" Motion key mappings
noremap j gj
noremap k gk
nnoremap ' `
nnoremap ` '
noremap <Tab> <C-w>w
noremap <S-Tab> <C-w>W
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Toggle between jumping and resizing windows
function ToggleMoveResize()
  let g:my_resizing_keys =
        \ exists("g:my_resizing_keys") ? !g:my_resizing_keys : 1
  if g:my_resizing_keys
    noremap <c-h> :verti resize -5<CR>
    noremap <c-j> :resize -5<CR>
    noremap <c-k> :resize +5<CR>
    noremap <c-l> :verti resize +5<CR>
  else
    noremap <c-h> <C-w>h
    noremap <c-j> <C-w>j
    noremap <c-k> <C-w>k
    noremap <c-l> <C-w>l
  endif
endfunction
:call ToggleMoveResize()
noremap <Leader>w :call ToggleMoveResize()<CR>

" Make current window 90 columns
noremap <C-w>. :verti resize 90<CR>


" Format selection
nnoremap <leader>fg :%!gofmt<CR>
nnoremap <leader>fc :%!clang-format<CR>
nnoremap <leader>fx :%!xmllint --format --recover - 2>/dev/null<CR>
nnoremap <leader>fj :%!python -m json.tool<CR>

" View Blame of a file
nnoremap <leader>vb :vnew <bar> 0read! git blame # \|\| hg blame -pu #<CR>


" Highlight column 80 (color set here because most themes don't specify it)
set colorcolumn=80,100
hi ColorColumn ctermbg=Gray ctermfg=Black guibg=#404040


" Auto Commands
if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded = 1

  " Turn off highlighting on start
  au VimEnter * nohls

  " Jump to the last known cursor position (unless git commit message)
  au BufReadPost * if &filetype !~ '^git\c' 
    \ && line("'\"") > 0
    \ && line("'\"") <= line("$")
    \ | exe "normal g`\"" | endif

  " Show whitespace chars while in insert mode
  au InsertEnter * :set list
  au InsertLeave * :set nolist

  " toggle spell on text files
  au FileType text set spell

  " Remove whitespace on save
  au BufWrite *.rs,*.c,*.cc,*.cpp,*.cxx,*.c++,*.h,*.hh,*.hpp,*.go,*.py,*.sh
    \ mark ' | silent! %s/\s\+$// | norm ''

  " Use real tabs in makefiles and gocode
  au BufEnter,BufNewFile,BufRead Makefile*,*.mk,*.go
    \ set noexpandtab

  " Tweak formatting for python
  au FileType python
    \ setlocal foldmethod=indent tabstop=4 shiftwidth=4 softtabstop=4

  " add shebang line for scripts
  au BufNewFile *.sh 0put = '#!/usr/bin/env bash' | norm G
  au BufNewFile *.py 0put = '#!/usr/bin/env python' | norm G
endif


" Load more extensive config
if !empty(glob("~/Source/dotfiles/vimrc.full"))
  source ~/Source/dotfiles/vimrc.full
endif
