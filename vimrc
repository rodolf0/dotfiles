" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
set nocompatible
set autoindent                 " always set auto-indenting on
set autoread                   " Auto read when a file is changed from the outside
set backspace=indent,eol,start " backspace config
set completeopt=menu           " menuone,preview,longest
set expandtab                  " expandir tabs a espacios
set fdls=99                    " keep open up to 6 fold levels
set ffs=unix,dos,mac           " Default file types
set foldmethod=syntax          " folds are defined by syntax
set history=3000               " Sets how many lines of history VIM has to remember
set hlsearch                   " highlight search terms
set ignorecase                 " case insensitive search
set incsearch                  " find as you type search
set nolist
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮
set fillchars+=vert:│
set magic               " set magic on, for regular expressions
set mat=2               " How many tenths of a second to blink
set mouse=a             " automatically enable mouse usage
set nolazyredraw        " don't redraw while executing macros
set nowrap              " don't wrap lines
set ruler               " always show cursor position
set scrolloff=5         " when moving outside viewport, give more context
set shiftwidth=2        " tabular a 2 espacios
set tabstop=2           " indentacion cada 2 columnas
set softtabstop=2       " para cuando usamos tabs, considerar estos espacios
set shortmess=atToO     " avoid annoying prompts
set showbreak=↪\
set showcmd             " show partial commands on status line
set showmatch           " show matching brackets/parenthesis
set showmode            " show what mode we're in
set sidescroll=5        " keep columns in context
set smartcase           " case sensitive when uc present
set smartindent
set smarttab
set splitright
set splitbelow
set synmaxcol=800       " stop syntax interpretation at 800 cols
set notimeout           " don't timeout on key mappings
set ttimeout            " timeout on keys
set ttimeoutlen=100
set wildignore+=*.o,*~,*.so,.svn,CVS,.git,*.a,*.class,*.obj,*.la,*.swp
set wildmenu           " show list instead of just completing
set wildmode=full      " open wildmenu matching first element
syntax on              " use syntax hilighting
set noerrorbells
set novisualbell
set encoding=utf8   " Language and encoding
set t_vb=           " visual bell
if !has('nvim')
  set ttymouse=xterm2
else
  set termguicolors    " enable true color
endif
" Directories setup: backups, undo
set backup
set backupdir=~/.vimfiles
set directory=~/.vimfiles
set viewdir=~/.vimfiles
"Persistent undo
if has('undodir')
  set undodir=~/.vimfiles
  set undofile
endif
colorscheme torte

" * Key Mappings {
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" escape the terminal with C-g
if has('nvim')
  tnoremap <C-g> <C-\><C-n>
endif

" copy/pasting to clipboard with <space>p/y
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

" save files easier
nnoremap <silent> <Leader>w :w<CR>
" switch to current file's dir
nnoremap <silent> <leader>cd :cd %:h<CR>
" clear search
nnoremap <Leader><CR> :nohlsearch<CR>

inoremap jk <ESC>

" feature toggling
nnoremap <silent> <leader>tp :set invpaste<CR>
nnoremap <silent> <leader>tc :set invcursorline invcursorcolumn<CR>
nnoremap <silent> <leader>ts :set invspell<CR>
nnoremap <silent> <leader>tn :set invnumber invrelativenumber<CR>

" format selection
nnoremap <silent> <leader>fg :%!gofmt<CR>
nnoremap <silent> <leader>fc :%!clang-format<CR>
nnoremap <silent> <leader>fx :%!xmllint --format --recover - 2>/dev/null<CR>
nnoremap <silent> <leader>fj :%!python -m json.tool<CR>

" motion
noremap j gj
noremap k gk
nnoremap ' `
nnoremap ` '
noremap <Tab> <C-w>w
noremap <S-Tab> <C-w>W
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

function ToggleMoveResize()
  let g:my_resizing_keys = exists("g:my_resizing_keys") ? !g:my_resizing_keys : 1
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
noremap <Leader><Leader> :call ToggleMoveResize()<CR>
:call ToggleMoveResize()
" }

" Highlight column 80 (color set here because most themes don't specify it)
if v:version >= 703
		set cc=80
		hi ColorColumn ctermbg=Gray ctermfg=Black guibg=#404040
		if(!exists('vimrc_already_sourced'))
				command Skinny set cc=73
				command Wide set cc=80
		endif
endif

" * Auto Commands {
if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded = 1
  au VimEnter * nohls       " turn off highlighting on start
  " Jump to the last known cursor position (unless git commit message)
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \ | exe "normal g`\"" | endif

  " no trailing chars on insert mode (if not in unite mode)
  au InsertEnter * if !exists("b:in_unite") | :set list | endif
  au InsertLeave * if !exists("b:in_unite") | :set nolist | endif
  au Filetype unite :let b:in_unite=1

  " toggle spell on text files
  au FileType text set spell

  augroup Coding
    au!
    " remove whitespace on save
    au BufWrite *.rs,*.c,*.cc,*.cpp,*.cxx,*.c++,*.h,*.hh,*.hpp,*.go,*.py,*.sh mark ' | silent! %s/\s\+$// | norm ''

    " use real tabs in makefiles and gocode
    au BufEnter,BufNewFile,BufRead Makefile*,*.mk,*.go set noexpandtab

    " python specific
    au FileType python setlocal foldmethod=indent tabstop=4 shiftwidth=4 softtabstop=4

    " add shebang line for scripts
    au BufNewFile *.sh 0put = '#!/usr/bin/env bash' | norm G
    au BufNewFile *.py 0put = '#!/usr/bin/env python' | norm G

  augroup END

endif " has("autocmd")
" }

if !empty(glob("~/Source/dotfiles/vimrc.full"))
  source ~/Source/dotfiles/vimrc.full
endif
