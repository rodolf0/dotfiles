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
" Tree file explorer
Plug 'kyazdani42/nvim-tree.lua'
" Autoclose matching parenthesis/braces/etc
Plug 'windwp/nvim-autopairs'
" Easy comments
Plug 'numToStr/Comment.nvim'
" Used for exchanging windows
Plug 't9md/vim-choosewin'
" Highlight jump targets for f F t T
Plug 'unblevable/quick-scope'
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
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'  " config for LSP client
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " auto-completion

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
local servers = {
  "pylsp", -- https://github.com/python-lsp/python-lsp-server
  -- "pyre", --  python -m pip install --user pyre-check
  "pyright", -- https://github.com/microsoft/pyright
  "clangd", -- https://clangd.llvm.org/installation#compile_commandsjson
  "rust_analyzer", -- https://rust-analyzer.github.io/manual.html
  "gopls", -- https://github.com/golang/tools/tree/master/gopls
}
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
end
-- Automatically start coq
vim.g.coq_settings = { auto_start = 'shut-up' }  -- before require("qoc")
-- LSP config. NOTE: coq wraps on_attach config for LSP to enhance it
for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup(
    -- add auto-completion via coq
    require('coq').lsp_ensure_capabilities({
      on_attach = on_attach,
    })
  )
end
EOF
" ###################################

" ############ nvim-tree ############
lua <<EOF
require("nvim-tree").setup({
  on_attach=function(bufnr)
    local nt_api = require("nvim-tree.api")
    local bufopts = {noremap=true, silent=true, buffer=bufnr}
    vim.keymap.set("n", "<Esc>", nt_api.tree.close, bufopts)
    vim.keymap.set("n", "/", nt_api.live_filter.start, bufopts)
  end,
  remove_keymaps={"<Tab>"},
  live_filter={always_show_folders=false},
})
EOF
" Mappings https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L1077
nnoremap <leader>e :NvimTreeFocus<CR>
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
lua << EOF
require("leap").setup{}
require("leap").set_default_keymaps()
EOF
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
