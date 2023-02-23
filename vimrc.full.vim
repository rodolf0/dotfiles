" Setup vim-plug (https://github.com/junegunn/vim-plug)
call plug#begin(has('nvim') ? expand("~/.config/nvim/bundle")
                            \ : expand("~/.vim/bundle"))
" Telescope
Plug 'nvim-lua/plenary.nvim' " required for Telescope
Plug 'kyazdani42/nvim-web-devicons' " Optional but nice
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " multiple words filter
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " TODO: check tag

" Aesthetics
Plug 'sainnhe/sonokai'
Plug 'itchyny/lightline.vim'
" focus on the code you're editing
Plug 'folke/twilight.nvim'
" Autoclose matching parenthesis/braces/etc
Plug 'windwp/nvim-autopairs'
" Easy comments
Plug 'numToStr/Comment.nvim'
" Used for exchanging windows
Plug 't9md/vim-choosewin'
" Incremental visual-mode selection
Plug 'terryma/vim-expand-region'
" Match enhanced text-objects
Plug 'wellle/targets.vim'
" Jump around
Plug 'ggandor/leap.nvim'

" Syntax plugins
Plug 'rust-lang/rust.vim'
Plug 'hashivim/vim-terraform'

" LSP - https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'  " config for LSP client
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " auto-completion

" AI code completion
Plug 'Exafunction/codeium.vim'
call plug#end()


" ############ Telescope ############
lua <<EOF
local actions = require('telescope.actions')
require("telescope").setup({
  defaults={
    mappings={
      i={ ["<esc>"]=actions.close, ["<C-u>"]=false, },
      n={ ["<esc>"]=actions.close, },
    },
  }
})
require('telescope').load_extension('fzf')
EOF
nnoremap <leader>fr :Telescope oldfiles<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fs :Telescope live_grep<CR>  " requires ripgrep
" ###################################

" ############## LSP ################
lua <<EOF
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, {noremap=true, silent=true})
local servers = {
  "pylsp", -- https://github.com/python-lsp/python-lsp-server
  "pyright", -- https://github.com/microsoft/pyright
  "clangd", -- https://clangd.llvm.org/installation#compile_commandsjson
  "rust_analyzer", -- https://rust-analyzer.github.io/manual.html
  "gopls", -- https://github.com/golang/tools/tree/master/gopls
  "html", "eslint",
}
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  local keymap_opts = { noremap=true, silent=true, buffer=bufnr }
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, keymap_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, keymap_opts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = false } end, keymap_opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, keymap_opts)
end

-- Automatically start coq. NOTE: run before require("qoc")
vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = { -- https://github.com/ms-jpq/coq_nvim/blob/coq/docs/KEYBIND.md
    jump_to_mark = '',
    pre_select = true,
    bigger_preview = '',
    recommended = false,
  },
  display={ghost_text={enabled=false}},
}
-- LSP config. NOTE: coq wraps on_attach config for LSP to enhance it
for _, server in ipairs(servers) do
  require("lspconfig")[server].setup(
    -- add auto-completion via coq
    require('coq').lsp_ensure_capabilities({
      on_attach = on_attach,
    })
  )
end
EOF
" ###################################

" ######## COQ key-bindings ########
" NOTE: complemented with coq_settings above
ino <silent><expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
ino <silent><expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
ino <silent><expr> <Tab>   pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<Tab>"
ino <silent><expr> <CR>   pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
" ###################################

" ############ twilight #############
lua << EOF
require("twilight").setup {}
EOF
nnoremap <silent> <leader>tt :Twilight<CR>
" ###################################

" ####### nvim-autopairs ############
lua << EOF
require("nvim-autopairs").setup {}
EOF
" ###################################

" ########## Comment.vim ############
lua << EOF
require("Comment").setup({
  toggler = {line = '#'},
  opleader = {line = '#'},
})
EOF
" ###################################

" ########## leap.vim ###############
lua require("leap").setup{}
nno f <Plug>(leap-forward)
nno F <Plug>(leap-backward)
" ###################################

" Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 0
noremap <Leader>- :ChooseWinSwap<CR>

" Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
  \ 'iw'  :0, 'iW'  :0,
  \ 'i"'  :0, 'a"'  :0,
  \ 'i''' :0, 'a''' :0,
  \ 'i]'  :1, 'a]'  :1,
  \ 'ib'  :1, 'ab'  :1,
  \ 'iB'  :1, 'aB'  :1,
  \ 'ip'  :0,
  \ }

" Plug 'itchyny/lightline.vim'
let g:lightline = {
  \ 'mode_map':{'n':'N','i':'I','R':'R','v':'V','V':'VL',"\<C-v>":'VB','c':'C','s':'S','S':'SL',"\<C-s>":'SB','t':'T',},
  \ 'active': {
  \   'left': [['mode', 'paste'], ['readonly', 'filepath', 'modified']],
  \   'right': [['percent'], ['line'], ['charvaluehex']],
  \ },
  \ 'component': {'charvaluehex': '0x%B'},
  \ 'component_function': {'filepath': 'LightlineFilePath'},
  \ }
" Show full file path if possible (try relative to home) else filename
function! LightlineFilePath()
  let fname = expand('%:p:~:s?/data/users/rudolph/fbsource?~?')
  return winwidth(0) > 25 + len(fname) ? fname : expand('%:t')
endfunction
set noshowmode

colorscheme sonokai
