" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:


" * Vundle {
  set nocompatible    " Must be first: don't imitate VI
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#rc()

  Plugin 'gmarik/Vundle.vim'

  " Integration
  Plugin 'Valloric/YouCompleteMe'
  " run code through external syntax checkers
  Plugin 'scrooloose/syntastic'
  " text snippets
  Plugin 'SirVer/ultisnips'
  " error detection
  Plugin 'pyflakes'
  " Go
  Plugin 'jnwhiteh/vim-golang'
  " Rust
  Plugin 'wting/rust.vim'
  " access databases
  Plugin 'dbext.vim'
  " source control management
  Plugin 'vcscommand.vim'

  " interface
  Plugin 'jellybeans.vim'
  " extended matching for %
  Plugin 'matchit.zip'
  " jump around
  Plugin 'EasyMotion'
  Plugin 'Lokaltog/powerline'
  Plugin 'The-NERD-Commenter'
  Plugin 'The-NERD-tree'
  " fuzzy finder
  Plugin 'kien/ctrlp.vim'
  " text aligning
  Plugin 'Tabular'
  " automatically close ([...
  Plugin 'Raimondi/delimitMate'
  " user vim buffers as term
  Plugin 'nicoraffo/conque'

  " Enable filetype plugin: detect file type
  filetype plugin indent on
" }


" * General {
  set autochdir                                                          " Always switch to the current file directory
  set autoindent                                                         " always set auto-indenting on
  set autoread                                                           " Auto read when a file is changed from the outside
  set backspace=indent,eol,start                                         " backspace config
  set completeopt=menu                                                   " menuone,preview,longest                            " what to show on omnicompletion
  set expandtab                                                          " expandir tabs a espacios
  set fdls=99                                                            " keep open up to 6 fold levels
  set ffs=unix,dos,mac                                                   " Default file types
  set foldmethod=syntax                                                  " folds are defined by syntax
  set history=3000                                                       " Sets how many lines of history VIM has to remember
  set hlsearch                                                           " highlight search terms
  set ignorecase                                                         " case insensitive search
  set incsearch                                                          " find as you type search
  set nolist
  set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮
  set magic                                                              " set magic on, for regular expressions
  set mat=2                                                              " How many tenths of a second to blink
  set mouse=a                                                            " automatically enable mouse usage
  set nolazyredraw                                                       " don't redraw while executing macros
  set nowrap                                                             " don't wrap lines
  set ruler                                                              " always show cursor position
  set scrolloff=5                                                        " when moving outside viewport, give more context
  set shiftwidth=2                                                       " tabular a 2 espacios
  set tabstop=2                                                          " indentacion cada 2 columnas
  set softtabstop=2                                                      " para cuando usamos tabs, considerar estos espacios
  set shortmess+=filmnrxoOtT                                             " abbrev. of messages (avoids 'hit enter')
  set showbreak=↪\
  set showcmd                                                            " show partial commands on status line
  set showmatch                                                          " show matching brackets/parenthesis
  set showmode                                                           " show what mode we're in
  set sidescroll=5                                                       " keep columns in context
  set smartcase                                                          " case sensitive when uc present
  set smartindent
  set smarttab
  set splitright
  set splitbelow
  set synmaxcol=800                                                      " stop syntax interpretation at 800 cols
  set notimeout                                                          " don't timeout on key mappings
  set ttimeout                                                           " timeout on keys
  set ttimeoutlen=100
  set ttymouse=xterm2                                                    " automatically enable mouse usage
  set wildignore+=*.o,*~,*.so,.svn,CVS,.git,*.a,*.class,*.obj,*.la,*.swp
  set wildmenu                                                           " show list instead of just completing
  set wildmode=full                                                      " open wildmenu matching first element
  set winminwidth=10                                                     " minimum window width
  syntax on                                                              " use syntax hilighting

  " No sound on errors
  set noerrorbells
  set novisualbell
  set t_vb=             " visual bell

  " * Colors and Fonts {
    set gfn=Monospace\ 9  " Set font according to system
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=r
    if ! has("gui_running")
      set t_Co=256      " number of colors
    endif
    colorscheme jellybeans
    set encoding=utf8   " Language and encoding
    try
      lang es_AR
    catch
    endtry
  " }

  " Directories setup: backups, undo {
    set backup            " backups are nice ...
    set backupdir=~/.vimbackups,~/tmp,/tmp
    set directory=~/.vimswap,~/tmp,/tmp
    set viewdir=~/.vimviews,~/tmp,/tmp
    "Persistent undo
    if has('undodir')
      set undodir=~/.vimundo,~/tmp,/tmp
      set undofile
    endif
  " }
" }


" * Key Mappings {
  let mapleader = ","
  let g:mapleader = ","

  " feature toggling
  nmap <silent> <leader>th :set invhlsearch<CR>
  nmap <silent> <leader>tl :set invlist<CR>
  nmap <silent> <leader>tp :set invpaste<CR>
  nmap <silent> <leader>tc :set invcursorline invcursorcolumn<CR>
  nmap <silent> <leader>ts :set invspell<CR>

  " toggle current fold with <space>
  nnoremap <Space> za
  " clear seach highlight on return
  nnoremap <CR> :nohlsearch<CR>

  " motion
  noremap <Tab> <C-W>w
  noremap <S-Tab> <C-W>W
  noremap j gj
  noremap k gk
  nnoremap ' `
  nnoremap ` '
  cnoremap <C-a> <Home>
  cnoremap <C-e> <End>

  " resize windows
  noremap <C-l> :verti resize +3<CR>
  noremap <C-h> :verti resize -3<CR>
  noremap <C-k> :resize +3<CR>
  noremap <C-j> :resize -3<CR>

  " formatting: switch between camel-case and underscores
  vnoremap <leader>fu :s/\<\@!\([A-Z]\)/\_\l\1/g<CR>gul
  vnoremap <leader>fc :s/_\([a-z]\)/\u\1/g<CR>gUl

  " move around whole lines
  nmap <C-Up> mz:m-2<cr>`z
  nmap <C-Down> mz:m+<cr>`z
  vmap <C-Down> :m'>+<cr>`<my`>mzgv`yo`z
  vmap <C-Up> :m'<-2<cr>`>my`<mzgv`yo`z
" }


" * Plugin Config  {
  " YCM
  let g:ycm_extra_conf_globlist = ['~/Source/*', '/data/users/rudolph/fbcode-hg/*']
  let g:ycm_min_num_identifier_candidate_chars = 4
  let g:ycm_error_symbol = 'x'
  let g:ycm_warning_symbol = '!'
  nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
  " NERDTree
  map <F2> :NERDTreeToggle<CR>
  " NERDCommenter
  let g:NERDCreateDefaultMappings = 0 " too polluting
  map # <Plug>NERDCommenterToggle
  " UltiSnips
  let g:UltiSnipsExpandTrigger = "<C-J>"
  let g:UltiSnipsJumpForwardTrigger = "<C-J>"
" }


" * Auto Commands {
if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded = 1
  au VimEnter * nohls       " turn off highlighting on start
  " Jump to the last known cursor position (unless git commit message)
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \ | exe "normal g`\"" | endif

  " no trailing chars on insert mode
  au InsertEnter * :set list
  au InsertLeave * :set nolist

  " let text files be a little narrower to allow comments with no wrapping
  au FileType text setlocal textwidth=78 | set spell

  augroup Coding
    au!
    " remove whitespace on save
    au BufWrite *.rs,*.c,*.cc,*.cpp,*.cxx,*.c++,*.h,*.hh,*.hpp,*.go,*.py,*.sh mark ' | silent! %s/\s\+$// | norm ''

    " add formatting tools when entering a buffer
    au BufEnter *.go nnoremap <F3> mp :%!gofmt<CR> 'p
    au BufEnter *.cc,*.c,*.cpp,*.c++,*.h,*.hh,*.hpp nnoremap <F3> mp :%!clang-format<CR> 'p
    au BufEnter *.xml nnoremap <F3> mp :%!xmllint --format --recover - 2>/dev/null<CR> 'p
    au BufEnter *.json nnoremap <F3> mp :%!python -m json.tool<CR> 'p
    au BufLeave *.go,*.cc,*.c,*.cpp,*.c++,*.h,*.hh,*.hpp,*.xml,*.json nunmap <F3>

    " use real tabs in makefiles and gocode
    au BufEnter,BufNewFile,BufRead Makefile*,*.mk,*.go set noexpandtab

    " python specific
    au FileType python set foldmethod=indent

    " add shebang line for scripts
    au BufNewFile *.sh 0put = '#!/usr/bin/env bash' | norm G
    au BufNewFile *.py 0put = '#!/usr/bin/env python' | norm G

    au Filetype conque_term se nospell

  augroup END

endif " has("autocmd")
" }
