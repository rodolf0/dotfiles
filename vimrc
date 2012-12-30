
" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" warlock's vimrc file
" }


" * Vundle {
  set nocompatible    " Must be first: don't imitate VI
  filetype off
  set rtp+=~/.vim/bundle/vundle
  call vundle#rc()

  Bundle 'gmarik/vundle'

  " languages
  "Bundle 'pydoc.vim'
  Bundle 'PySmell'
  Bundle 'pep8'
  Bundle 'pyflakes'
  Bundle 'jnwhiteh/vim-golang'
  Bundle 'Rip-Rip/clang_complete'

  " interface
  Bundle 'jellybeans.vim'
  Bundle 'Lokaltog/vim-powerline'
  Bundle 'AutoComplPop'
  Bundle 'SuperTab-continued.'
  Bundle 'The-NERD-Commenter'
  Bundle 'The-NERD-tree'
  Bundle 'ctrlp.vim'
  Bundle 'taglist-plus'
  Bundle 'matchit.zip'
  Bundle 'utl.vim'

  Bundle 'dbext.vim'
  Bundle 'vcscommand.vim'
  Bundle 'colorv.vim'

  " text formatting
  Bundle 'Tabular'
  Bundle 'Townk/vim-autoclose'
  Bundle 'vim-orgmode'
  Bundle 'UltiSnips'
  "Bundle 'easytags.vim'

  " Enable filetype plugin: detect file type
  filetype plugin indent on
" }


" * General {
  set history=3000    " Sets how many lines of history VIM has to remember
  set mouse=a         " automatically enable mouse usage
  set ttymouse=xterm2 " automatically enable mouse usage
  set autoread        " Auto read when a file is changed from the outside
  set autochdir       " Always switch to the current file directory
  set shortmess+=filmnrxoOtT  " abbrev. of messages (avoids 'hit enter')
  " set spell         " spell checking on
  set ffs=unix,dos,mac "Default file types

  " Directories setup: backups, undo {
    set backup            " backups are nice ...
    set backupdir=~/.vimbackups,~/tmp,/tmp
    set directory=~/.vimswap,~/tmp,/tmp
    set viewdir=~/.vimviews,~/tmp,/tmp

    "" Creating directories if they don't exist
    "silent execute '!mkdir -p $HOME/.vimbackups'
    "silent execute '!mkdir -p $HOME/.vimswap'
    "silent execute '!mkdir -p $HOME/.vimviews'
    au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
    au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

    "Persistent undo
    if has('undodir')
      set undodir=~/.vimundo,~/tmp,/tmp
      " silent execute '!mkdir -p $HOME/.vimundo'
      set undofile
    endif
  " }

  " With a map leader it's possible to do extra key combinations
  let mapleader = ","
  let g:mapleader = ","
  " When vimrc is edited, reload it
  "autocmd! bufwritepost .vimrc source ~/.vimrc
" }


" * VIM user interface {
  set wildmenu          " show list instead of just completing
  set wildmode=full     " open wildmenu matching first element
  set wildignore+=*.o,*~,*.so,.svn,CVS,.git,*.a,*.class,*.obj,*.la,*.swp
  set ruler             " always show cursor position
  set showcmd           " show partial commands on status line
  "set number            " set line numbers
  set nolazyredraw      " don't redraw while executing macros
  set foldmethod=syntax " syntaxis define folds
  set fdls=99           " keep open up to 6 fold levels
  set scrolloff=5       " when moving outside viewport, give more context
  set showmode          " show what mode we're in

  syntax on             " use syntax hilighting
  "set matchpairs+=<:>   " match, to be used with %
  set showmatch         " show matching brackets/parenthesis
  set mat=2             " How many tenths of a second to blink
  set incsearch         " find as you type search
  set hlsearch          " highlight search terms
  set ignorecase        " case insensitive search
  set smartcase         " case sensitive when uc present
  set magic             " set magic on, for regular expressions
  set listchars=tab:>-,trail:·,eol:$

  set backspace=indent,eol,start " backspace config
  "set whichwrap=b,s,h,l,<,>,[,]  " backspace and cursor keys wrap to
  "set winminheight=10    " min win height
  set winminwidth=10    " minimum window width
  set completeopt=menu  "menuone,preview,longest   " what to show on omnicompletion

  " No sound on errors
  set noerrorbells
  set novisualbell
  set t_vb=             " visual bell

  " * Colors and Fonts {
    set gfn=Monospace\ 9  " Set font according to system
    " Set color theme
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=r
    if ! has("gui_running")
      set t_Co=256          "number of colors
    endif
    "set background=dark
    "colorscheme Mustang
    colorscheme jellybeans
    " Language and encoding
    set encoding=utf8
    try
      lang es_AR
    catch
    endtry
  " }
" }


" * Formatting {
  set nowrap             " don't wrap lines
  set autoindent         " always set autoindenting on
  set shiftwidth=2       " tabular a 2 espacios
  set expandtab          " expandir tabs a espacios
  set tabstop=2          " indentacion cada 2 columnas
  set softtabstop=2      " para cuando usamos tabs, considerar estos espacios
  set smarttab
  set smartindent
" }


" * Key Mappings {
  " General Control {
    nmap <silent> ts :set invhlsearch<CR>
    nmap <silent> tl :set invlist<CR>
    nmap tp :set invpaste<CR>
    nmap <silent> tc :set invcursorline invcursorcolumn<CR>
    nmap <silent> tr :set invnumber<CR>
    nmap <silent> t% :tabedit %<CR>
    nmap <silent> <leader>vd :VCSVimDiff<CR>
    nmap <silent> <leader>ts :set invspell<CR>
    " Map space to / (search)
    noremap <space> /
    " Use tab to go to next buffer
    noremap <Tab> <C-W>w
    noremap <S-Tab> <C-W>W

    noremap <C-t> :tabnew<cr>
    noremap <C-x> :close<cr>
    noremap <C-b> :ConqueTermVSplit bash<cr>
    map <C-F9> :exe ':mkses! ~/.vim/session-' . hostname() . '.vim'<cr>
    map <S-F9> :exe 'so ~/.vim/session-' . hostname() . '.vim'<cr>
  " }

  " Improve navigation {
    " line wrap motion
    noremap j gj
    noremap k gk
    " use ' to jump back to column instead of line
    nnoremap ' `
    nnoremap ` '

    " Buffer Switching
    noremap <C-J> <C-W>j
    noremap <C-K> <C-W>k
    noremap <C-L> <C-W>l
    noremap <C-H> <C-W>h

    " <home> toggles between start of line and start of text {
      imap <khome> <home>
      nmap <khome> <home>
      inoremap <silent> <home> <C-O>:call Home()<CR>
      nnoremap <silent> <home> :call Home()<CR>
      function Home()
          let curcol = wincol()
          normal ^
          let newcol = wincol()
          if newcol == curcol
              normal 0
          endif
      endfunction
    " }

    "<end> goes to end of screen before end of line {
      imap <kend> <end>
      nmap <kend> <end>
      inoremap <silent> <end> <C-O>:call End()<CR>
      nnoremap <silent> <end> :call End()<CR>
      function End()
          let curcol = wincol()
          normal g$
          let newcol = wincol()
          if newcol == curcol
              normal $
          endif
          "The following is to work around issue for insert mode only.
          "normal g$ doesn't go to pos after last char when appropriate.
          "More details and patch here:
          "http://www.pixelbeat.org/patches/vim-7.0023-eol.diff
          if virtcol(".") == virtcol("$") - 1
              normal $
          endif
      endfunction
    " }
  " }

  " Bash like keys for the command line
  cnoremap <C-A>      <Home>
  cnoremap <C-E>      <End>
  cnoremap <C-K>      <C-U>

  " Text Editing {
    "Move a line of text
    nmap <C-Up> mz:m-2<cr>`z
    nmap <C-Down> mz:m+<cr>`z
    vmap <C-Down> :m'>+<cr>`<my`>mzgv`yo`z
    vmap <C-Up> :m'<-2<cr>`>my`<mzgv`yo`z
    " Change selected text from NameLikeThis to name_like_this.
    vnoremap <leader>u :s/\<\@!\([A-Z]\)/\_\l\1/g<CR>gul
    " Change selected text from name_like_this to NameLikeThis.
    vnoremap ,c :s/_\([a-z]\)/\u\1/g<CR>gUl
    " format a json file to look nice
    com FormatJson :%!python2 -m json.tool
  " }

  " Map alt keys when not recognized with vim (need to map each one)
  " set <M-x>=x
  " set <M-a>=a
" }


" * Plugin Configs  {

  map <F2> :NERDTreeToggle<CR>
  map <F3> :TlistToggle<CR>
  map <F4> <Plug>TaskList

  let g:dbext_default_usermaps = 1

  " * NERD commenter  {
    let g:NERDCreateDefaultMappings = 0 " too polluting
    map # <Plug>NERDCommenterToggle
  " }

  " * Easytags  {
    " don't let easytags work when you stop typing... try if slow
    "let g:easytags_on_cursorhold = 0
    let g:easytags_updatetime_autodisable = 1
    let g:easytags_by_filetype = "~/.vimtags.d/"
    set tags+=~/.myctags
    " build tags for current dir and append them to ~/.myctags
    function BuildMyTags()
      :!ctags -R --sort=yes --C-kinds=+pl --C++-kinds=+pl --fields=+iaSl --extra=+q -a -f ~/.myctags .
    endfunction
    nmap <C-F12> :call BuildMyTags()<CR>
  " }

  " * clang complete {
    "let g:clang_library_path = '/usr/lib/llvm'
    let g:clang_use_library = 1
    let g:clang_auto_select = 1
    "let g:clang_user_options = '|| exit 0'
    map <F6> :call g:ClangUpdateQuickFix()<CR>
  " }

  " * auto close {
    let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}
  " }

  " * supertab {
    "let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
    let g:SuperTabDefaultCompletionType = "context"
  " }

  " * dbext {
    let g:dbext_default_profile_PROD = 'type=ORA:user=***********:passwd=******:srvname=PROD'
    let g:dbext_default_profile_PDW = 'type=ORA:user=***********:passwd=******:srvname=PDW'
    let g:dbext_default_profile_DW = 'type=ORA:user=***********:passwd=******:srvname=DW'
    let g:dbext_default_profile = 'PDW'

    com Pdw :DBSetOption profile='PDW'
    com Prod :DBSetOption profile='PROD'
    com Dw :DBSetOption profile='DW'
  " }

" }


" * Auto Commands {
if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded = 1

  au VimEnter * nohls       " turn off hilighting uppon start

  " remove whitespace on save
  au BufWrite *.cc,*.go,*.h,*.crush,*.cpp,*.java,*.py,*.sh,*.c mark ' | silent! %s/\s\+$// | norm ''

  " Jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup Coding
    au!
    " add shebang line for scripts
    au BufNewFile *.sh 0put = '#!/usr/bin/env bash' | norm G
    au BufNewFile *.py 0put = '#!/usr/bin/env python' | norm G

    " set a nice modeline for our new code files
    au BufNewFile *.h,*.hh,*.c,*.cpp,*.cc,*.java 0put = '' |
        \ $put = '/* vim: set sw=2 sts=2 : */' |
        \ set sw=2 sts=2 et tw=80 | norm gg
    au BufNewFile *.sh,*.py
        \ $put = '# vim: set sw=2 sts=2 : #' |
        \ set sw=2 sts=2 et tw=80 | norm 2G

    " re format go code on save
    "au BufWrite *.go :Fmt

    " Mark 80 columns
    fu! ShowWhiteSpace()
      highlight WhitespaceEOL ctermbg=red guibg=red
      match WhitespaceEOL '\(\s\+$\|\(^.\{80,\}\)\@<=.\)'
    endfu
    "au BufNewFile,BufReadPost *.c,*.h,*.crush,*.sh,*.pl,*.java,*.cc,*.py call ShowWhiteSpace()


    " Makefile template
    au BufNewFile Makefile,*.mak 0put = 'TARGET='|
        \ $put ='all: $(TARGET)'|
        \ $put ='' |
        \ $put ='clean:'|
        \ $put ='	rm -f *.o $(TARGET)'|
        \ norm gg$

    " use real tabs in makefiles and gocode
    au BufEnter,BufNewFile,BufRead Makefile*,*.mk,*.go set noexpandtab

    " for .crush files, use the custom syntax file
    au BufEnter,BufNewFile,BufRead *.crush* setf crush
    au! Syntax crush source $HOME/.vim/syntax/crush.vim

    " let text files be a little narrower to allow comments with no wrapping
    au FileType text setlocal textwidth=78
    au FileType python set foldmethod=indent

  augroup END

endif " has("autocmd")
" }
