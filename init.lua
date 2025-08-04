--
-- Geneeral config ---------------------------------------------
--
vim.g.have_nerd_font = true -- Flag to use in rest of config
vim.g.mapleader = " " -- Set <space> as the leader key
vim.g.maplocalleader = " "
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.timeoutlen = 300 -- Mapped sequ wait (faster which-key popup)
vim.opt.updatetime = 250 -- Delay for CursorHold (highlight LSP)
vim.opt.undofile = true -- Save undo history
vim.opt.autochdir = true -- Adjust PWD to that of current buffer
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` for faster startup-time.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

--
-- Display -----------------------------------------------------
--
vim.opt.showmatch = true -- Show matching parenthesis
-- vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.breakindent = true -- Wraped lines preserve indent on break
vim.opt.showbreak = "↪ "
vim.opt.wrap = false
vim.opt.cursorline = false -- Show which line your cursor is on
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = false
vim.opt.list = false -- Display whitespace
vim.opt.listchars = "eol:¬,tab:▸ ,trail:•,extends:❯,precedes:❮"
-- Toggle list on insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.opt.list = true
	end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.opt.list = false
	end,
})

--
-- Key maps ----------------------------------------------------
--
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Easier exit for terminal mode (May not work in tmux)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-g>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<M-h>", "<C-w>5<", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-l>", "<C-w>5>", { desc = "Increase window width" })
vim.keymap.set("n", "<M-j>", "<C-w>3-", { desc = "Decrease window height" })
vim.keymap.set("n", "<M-k>", "<C-w>3+", { desc = "Increase window height" })
vim.keymap.set("n", "j", "gj") -- Easier move on wrapped lines
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "'", "`") -- remember column position on marks
vim.keymap.set("n", "<leader>z", ":ZenMode<CR>") -- Enter focus mode
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--
-- Search config -----------------------------------------------
--
vim.opt.ignorecase = true -- case-insensitive search (unless \C), or smart
vim.opt.smartcase = true
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

-------------
-- plugins --
-------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- auto check for plugin updates
	checker = { enabled = true },
	spec = {
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
		-- Common functions for manu plugins
		"nvim-lua/plenary.nvim",
		-- Vim corner notifications and progress messages
		{ "j-hui/fidget.nvim", opts = {} },
		-- zoom / focus window
		{ "folke/zen-mode.nvim", opts = {} },
		-- Useful plugin to show you pending keybinds.
		{
			"folke/which-key.nvim",
			event = "VimEnter", -- Sets the loading event to 'VimEnter'
			opts = {
				icons = {
					mappings = vim.g.have_nerd_font, -- set to true if you have a Nerd Font
					keys = {}, --  use the default whick-key.nvim defined Nerd Font icons
				},
				-- Document existing key chains
				spec = {
					{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
					{ "<leader>d", group = "[D]ocument" },
					{ "<leader>r", group = "[R]ename" },
					{ "<leader>s", group = "[S]earch" },
					{ "<leader>w", group = "[W]orkspace" },
					{ "<leader>t", group = "[T]oggle" },
					{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
				},
			},
		},
		-- Autoformat
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					-- Disable "format_on_save lsp_fallback" for languages that don't
					-- have a well standardized coding style. You can add additional
					-- languages here or re-enable it for the disabled ones.
					local disable_filetypes = { c = true, cpp = true, rust = true }
					local lsp_format_opt
					if disable_filetypes[vim.bo[bufnr].filetype] then
						lsp_format_opt = "never"
					else
						lsp_format_opt = "fallback"
					end
					return {
						timeout_ms = 500,
						lsp_format = lsp_format_opt,
					}
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					-- You can use 'stop_after_first' to run the first available formatter from the list
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			},
		},
		-- Fuzzy Finder for everything (files, lsp, etc)
		{
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			branch = "0.1.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ -- If encountering errors, see telescope-fzf-native README for installation instructions
					"nvim-telescope/telescope-fzf-native.nvim",
					-- `build` is used to run some command when the plugin is installed/updated.
					build = "make",
					-- `cond` determine if this plugin should be installed and loaded.
					cond = function()
						return vim.fn.executable("make") == 1
					end,
				},
				{ "nvim-telescope/telescope-ui-select.nvim" }, -- let nvim interact with telescope
				-- Useful for getting pretty icons, but requires a Nerd Font.
				{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			},
			config = function()
				-- :Telescope help_tags
				-- Telescope help inside the dialogue
				--  - Insert mode: <c-/>
				--  - Normal mode: ?
				require("telescope").setup({
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown(),
						},
					},
				})
				-- Enable Telescope extensions if they are installed
				pcall(require("telescope").load_extension, "fzf")
				pcall(require("telescope").load_extension, "ui-select")
				-- See `:help telescope.builtin`
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
				vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
				vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
				vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
				vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
				vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
				vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
				vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files" })
				vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
				-- Slightly advanced example of overriding default behavior and theme
				vim.keymap.set("n", "<leader>/", function()
					-- You can pass additional configuration to Telescope to change the theme, layout, etc.
					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end, { desc = "[/] Fuzzily search in current buffer" })
				-- It's also possible to pass additional configuration options.
				--  See `:help telescope.builtin.live_grep()` for information about particular keys
				vim.keymap.set("n", "<leader>s/", function()
					builtin.live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end, { desc = "[S]earch [/] in Open Files" })
			end,
		},
		-- Highlight todo, notes, etc in comments
		{
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},
		-- Highlight, edit, and navigate code
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			main = "nvim-treesitter.configs", -- Sets main module to use for opts
			opts = {
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"go",
					"html",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"rust",
					"vim",
					"vimdoc",
				},
				auto_install = true, -- Autoinstall languages that are not installed
				highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
				indent = { enable = true, disable = { "ruby" } },
			},
		},
		-- "nvim-treesitter/nvim-treesitter-textobjects", -- TODO: configure
		"nvim-treesitter/nvim-treesitter-context", -- show context on scroll
		-- colorscheme
		{
			"folke/tokyonight.nvim",
			priority = 1000, -- Make sure to load this before all the other start plugins.
			opts = {
				style = "night",
				on_highlights = function(hi, colors)
					hi.WinSeparator.fg = colors.comment
				end,
			},
			init = function()
				vim.cmd.colorscheme("tokyonight-night")
			end,
		},
		--
		-- Main LSP Configuration
		--
		{ -- integrate mason wiht lsp-config
			"mason-org/mason-lspconfig.nvim",
			opts = {},
			dependencies = {
				-- Installs tools (linters, lsp-servers, etc)
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig", -- default base configs for LSPs
				"hrsh7th/cmp-nvim-lsp", -- extra capabilities provided by nvim-cmp
				{ -- use mason to keep tools updated
					"WhoIsSethDaniel/mason-tool-installer.nvim",
					-- This will automatically call require('<plugin>').setup(opts)
					-- Update this tool list when you need new LSP servers, linters, etc.
					opts = {
						ensure_installed = {
							"stylua", -- Used to format Lua code
							"lua_ls",
							"clangd",
							"gopls",
							"pylsp",
							"rust_analyzer",
						},
					},
				},
			},
			config = function()
				-- LSPs are external servers that provide symbols, refs, completion, etc.
				-- When attaching to a buffer LspAttach configures LSP for it.
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
					callback = function(event)
						-- Convinience function to define mappings
						local map = function(keys, func, desc, mode)
							mode = mode or "n"
							vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end
						-- Jump to the definition of the word under your cursor.
						map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
						-- Find references for the word under your cursor.
						map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
						-- Jump to the implementation of the word under your cursor.
						--  Useful for languages declaring types without an actual implementation.
						map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
						-- Jump to the type of the word under your cursor. (not where var was defined)
						map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
						-- Fuzzy find all the symbols in your current document.
						--  Symbols are things like variables, functions, types, etc.
						map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
						-- Fuzzy find all the symbols in your current workspace.
						--  Similar to document symbols, except searches over your entire project.
						map(
							"<leader>ws",
							require("telescope.builtin").lsp_dynamic_workspace_symbols,
							"[W]orkspace [S]ymbols"
						)
						-- Rename the variable under your cursor.
						map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
						-- Execute a code action, usually your cursor needs to be on top of an error
						-- or a suggestion from your LSP for this to activate.
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
						-- WARN: This is not Goto Definition, this is Goto Declaration.
						--  For example, in C this would take you to the header.
						map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

						-- The following two autocommands are used to highlight references of the
						-- word under your cursor when your cursor rests there for a little while.
						--    See `:help CursorHold` for information about when this is executed
						-- When you move your cursor, the highlights will be cleared (the second autocommand).
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if
							client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
						then
							local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
							-- highlight
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.document_highlight,
							})
							-- clear on move or LspDetach
							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.clear_references,
							})
							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({
										group = "lsp-highlight",
										buffer = event2.buf,
									})
								end,
							})
						end

						-- The following code creates a keymap to toggle inlay hints in your
						-- code, if the language server you are using supports them
						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end

						-- Automatically open a float window with diagnostics on CursorHold
						vim.api.nvim_create_autocmd("CursorHold", {
							group = vim.api.nvim_create_augroup("LspDiagnostics", { clear = true }),
							callback = function()
								vim.diagnostic.open_float({
									scope = "cursor",
									focusable = false,
									close_events = { "CursorMoved", "InsertCharPre", "BufLeave", "WinClosed" },
								})
							end,
						})
					end,
				})

				-- LSP clients/servers communicate what features they support.
				-- By default, Neovim doesn't support everything in the LSP spec.
				-- Adding nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
				-- Create new capabilities with nvim cmp, and then broadcast that to the servers.
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

				-- Enable the following language servers
				-- Available keys are:
				-- cmd (table): Override the default command used to start the server
				-- filetypes (table): Override the default list of associated filetypes for the server
				-- capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
				-- settings (table): Override the default settings passed when initializing the server.
				--     For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
				local servers = {
					clangd = {},
					gopls = {},
					pylsp = {},
					rust_analyzer = {},
					lua_ls = {
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					},
				}

				require("mason-lspconfig").setup({
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							-- This handles overriding only values explicitly passed
							-- by the server configuration above. Useful when disabling
							-- certain features of an LSP (for example, turning off formatting for tsserver)
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end,
					},
				})
			end,
		},
		--
		-- Autocompletion. Without this, Installed/configured LSPs don't interact with nvim
		--
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				-- Adds completion capabilities.
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				-- Snippet Engine & its associated nvim-cmp source
				{
					"L3MON4D3/LuaSnip",
					build = (function()
						-- Build Step is needed for regex support in snippets.
						-- This step is not supported in many windows environments.
						-- Remove the below condition to re-enable on windows.
						if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
							return
						end
						return "make install_jsregexp"
					end)(),
					dependencies = {
						-- `friendly-snippets` contains a variety of premade snippets.
						--    See the README about individual language/framework/plugin snippets:
						--    https://github.com/rafamadriz/friendly-snippets
						-- {
						--   'rafamadriz/friendly-snippets',
						--   config = function()
						--     require('luasnip.loaders.from_vscode').lazy_load()
						--   end,
						-- },
					},
				},
				"saadparwaiz1/cmp_luasnip",
			},
			config = function()
				-- See `:help cmp`
				local cmp = require("cmp")
				local luasnip = require("luasnip")
				luasnip.config.setup({})

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					completion = { completeopt = "menu,menuone,noinsert" },
					-- For an understanding of why these mappings were
					-- chosen, you will need to read `:help ins-completion`
					mapping = cmp.mapping.preset.insert({
						-- Select the [n]ext item
						["<C-n>"] = cmp.mapping.select_next_item(),
						-- Select the [p]revious item
						["<C-p>"] = cmp.mapping.select_prev_item(),
						-- Scroll the documentation window [b]ack / [f]orward
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						-- Accept ([y]es) the completion.
						--  This will auto-import if your LSP supports it.
						--  This will expand snippets if the LSP sent a snippet.
						["<Tab>"] = cmp.mapping.confirm({ select = true }),
						-- Manually trigger a completion from nvim-cmp.
						--  Generally you don't need this, because nvim-cmp will display
						--  completions whenever it has completion options available.
						["<C-Space>"] = cmp.mapping.complete({}),

						-- Snippet slots
						-- <c-l> will move you to the right of each of the expansion locations.
						-- <c-h> is similar, except moving you backwards.
						["<C-l>"] = cmp.mapping(function()
							if luasnip.expand_or_locally_jumpable() then
								luasnip.expand_or_jump()
							end
						end, { "i", "s" }),
						["<C-h>"] = cmp.mapping(function()
							if luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							end
						end, { "i", "s" }),
					}),
					sources = {
						{
							name = "lazydev",
							-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
							group_index = 0,
						},
						{ name = "nvim_lsp" },
						{ name = "path" },
						{ name = "luasnip" },
						-- { name = "codeium" },
					},
				})
			end,
		},
		-- Markdown preview
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
			opts = {},
		},
		-- Auto-insert relevant parens
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},
	},
})

-- vim: ts=2 sts=2 sw=2 et
