" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

" * Vundle {
  set nocompatible    " Must be first: don't imitate VI
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#rc()
  Plugin 'gmarik/Vundle.vim'

  Plugin 'Valloric/YouCompleteMe' " semantic auto-completion
  Plugin 'scrooloose/syntastic'   " syntax checks
  " Lang stuff
  Plugin 'nvie/vim-flake8'
  Plugin 'jnwhiteh/vim-golang'
  Plugin 'wting/rust.vim'
	Plugin 'nsf/gocode', {'rtp': 'vim/'}
  " interface
  Plugin 'jellybeans.vim'
  Plugin 'matchit.zip'              " match fancier tags with %
  Plugin 'terryma/vim-expand-region'
  Plugin 'bling/vim-airline'
  Plugin 'The-NERD-Commenter'
  Plugin 'Shougo/unite.vim'         " fuzzy file opener
  Plugin 'Shougo/neomru.vim'
  Plugin 'Shougo/vimfiler.vim'      " filesystem nav
  Plugin 't9md/vim-choosewin'       " move windows around
  Plugin 'Tabular'                  " text aligning
  Plugin 'Raimondi/delimitMate'     " automatically close ([...
  Plugin 'tpope/vim-obsession.git'  " session management

  " Enable filetype plugin: detect file type
  filetype plugin indent on
" }


" * General {
  "set autochdir                                                         " Always switch to the current file directory
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
  set shortmess+=filmnrxoOtT                                             " avoid annoying prompts
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
    set backup
    set backupdir=~/.vimfiles
    set directory=~/.vimfiles
    set viewdir=~/.vimfiles
    "Persistent undo
    if has('undodir')
      set undodir=~/.vimfiles
      set undofile
    endif
  " }
" }


" * Key Mappings {
  let mapleader = "\<Space>"
  let g:mapleader = "\<Space>"

  " copy/pasting to clipboard with <space>p/y
  vmap <Leader>y "+y
  vmap <Leader>d "+d
  vmap <Leader>p "+p
  vmap <Leader>P "+P
  nmap <Leader>p "+p
  nmap <Leader>P "+P

  " save files easier
  nnoremap <silent> <Leader>w :w<CR>

  " feature toggling
  nmap <silent> <leader>tp :set invpaste<CR>
  nmap <silent> <leader>tc :set invcursorline invcursorcolumn<CR>
  nmap <silent> <leader>ts :set invspell<CR>
  nmap <silent> <leader>te :VimFilerExplorer<CR>
  nmap <silent> <leader>tn :set invnumber<CR>

  " clear seach highlight on return
  nnoremap <CR> :nohlsearch<CR>

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
      noremap <C-h> :verti resize -5<CR>
      noremap <C-j> :resize -5<CR>
      noremap <C-k> :resize +5<CR>
      noremap <C-l> :verti resize +5<CR>
    else
      noremap <C-h> <C-w>h
      noremap <C-j> <C-w>j
      noremap <C-k> <C-w>k
      noremap <C-l> <C-w>l
    endif
  endfunction
  noremap <Leader><Leader> :call ToggleMoveResize()<CR>
  :call ToggleMoveResize()
" }


" * Plugin Config  {
  " YCM
  let g:ycm_extra_conf_globlist = ['~/Source/*', '/data/users/rudolph/fbcode-hg/*']
  let g:ycm_min_num_identifier_candidate_chars = 4
  let g:ycm_error_symbol = 'x'
  let g:ycm_warning_symbol = '!'
  nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
  " NERDCommenter
  let g:NERDCreateDefaultMappings = 0 " too polluting
  map # <Plug>NERDCommenterToggle
  " Unite
  "call unite#filters#matcher_default#use(['matcher_fuzzy'])
  nnoremap <leader>ff :Unite -start-insert -buffer-name=any file buffer<CR>
  nnoremap <leader>fb :Unite -start-insert -buffer-name=any buffer<CR>
  nnoremap <leader>fr :Unite -start-insert -buffer-name=mru file_mru<CR>
  " vim-expand-region
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
  " vimfiler/choosewin
  let g:vimfiler_as_default_explorer = 1
  let g:choosewin_overlay_enable = 0
  map - <Plug>(choosewin)
  noremap <Leader>- :ChooseWinSwap<CR>
" }


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

    " add formatting tools when entering a buffer
    au BufEnter *.go nnoremap <F3> mp :%!gofmt<CR> 'p
    au BufEnter *.cc,*.c,*.cpp,*.c++,*.h,*.hh,*.hpp nnoremap <F3> mp :%!clang-format<CR> 'p
    au BufEnter *.xml nnoremap <F3> mp :%!xmllint --format --recover - 2>/dev/null<CR> 'p
    au BufEnter *.json nnoremap <F3> mp :%!python -m json.tool<CR> 'p
    au BufLeave *.go,*.cc,*.c,*.cpp,*.c++,*.h,*.hh,*.hpp,*.xml,*.json nunmap <F3>

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
