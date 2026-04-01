local vim = vim
local Plug = vim.fn["plug#"]

-- vim.call('plug#begin')
vim.call("plug#begin", "~/.local/share/nvim/plugged")

Plug("bjarneo/pixel.nvim")

Plug("christoomey/vim-tmux-navigator")

Plug("nvim-treesitter/nvim-treesitter")

-- LSP Management
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("neovim/nvim-lspconfig")

-- Autocompletion
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
-- " follow latest release and install jsregexp.
Plug("L3MON4D3/LuaSnip", { ["tag"] = "v2.*", ["do"] = "make install_jsregexp" })
Plug("saadparwaiz1/cmp_luasnip")

-- UI / Diagnostics
Plug("folke/trouble.nvim")

Plug("nvim-lua/plenary.nvim")
Plug("MunifTanjim/nui.nvim")
Plug("nvim-tree/nvim-web-devicons")
Plug("nvim-neo-tree/neo-tree.nvim", { ["checkout"] = "v3.x" })

-- third-party tool
Plug("WhoIsSethDaniel/mason-tool-installer.nvim")

-- Formatter
Plug("stevearc/conform.nvim")

-- Folding
Plug("kevinhwang91/promise-async")
Plug("kevinhwang91/nvim-ufo")

-- Git
Plug("lewis6991/gitsigns.nvim")
Plug("sindrets/diffview.nvim")

-- Noice UI
Plug("MunifTanjim/nui.nvim")
Plug("rcarriga/nvim-notify")
Plug("folke/noice.nvim")

-- fzf
Plug("ibhagwan/fzf-lua")

vim.call("plug#end")

-- Inisialisasi sederhana untuk plugin yang membutuhkan setup
require("trouble").setup({})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"intelephense", -- LSP PHP yang sangat stabil
		"lua_ls",
	},
})

-- Cara baru Neovim 0.11 (Menggunakan vim.lsp.config)
-- Ini menggantikan require('lspconfig').intelephense.setup({})
vim.lsp.config("intelephense", {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = { "composer.json", ".git" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		intelephense = {
			inlayHints = {
				enable = true, -- Mengaktifkan hint dari sisi server
			},
		},
	},
})
vim.lsp.enable("intelephense")

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			runtime = { version = "LuaJIT" },
			telemetry = { enable = false },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})

vim.lsp.enable({ "lua_ls" })

require("plugins.noice")

-- Konfigurasi nvim-cmp untuk autocomplete dan snippet (luasnip)
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}),
	window = {
		documentation = cmp.config.disable,
		completion = cmp.config.window.bordered({
			border = "double",
			max_height = 5, -- Limits the height to 15 lines
			col_offset = 5,
		}),
		-- documentation = cmp.config.window.bordered({
		--           border = "double"
		--       }),
	},
	event = {
		change = function()
			local entry = cmp.get_selected_entry()
			print("aye")
		end,
		on_item_selected = function(event)
			Open_bottom_doc(event.entry)
		end,
		on_menu_closed = function()
			if Bottom_win and vim.api.nvim_win_is_valid(Bottom_win) then
				vim.api.nvim_win_close(Bottom_win, true)
				Bottom_win = nil
			end
		end,
	},
})

-- Keybindings LSP (Aktif otomatis saat LSP menempel ke buffer)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		local map = function(mode, lhs, rhs, desc)
			opts.desc = desc
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gr", vim.lsp.buf.references, "References")
		map("n", "gi", vim.lsp.buf.implementation, "Implementation")
		map("n", "K", vim.lsp.buf.hover, "Hover")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
		map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
		map("n", "<leader>e", vim.diagnostic.open_float, "Line diagnostics")

		-- Aktifkan Inlay Hints (Inline Hints) secara otomatis
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
		end
	end,
})

-- Setup Nvim Tree
local config_neo_tree = {}
require("neo-tree").setup({
	window = {
		position = "top",
		mappings = {
			["P"] = {
				"toggle_preview",
				config = {
					use_float = false,
					-- use_image_nvim = true,
					-- use_snacks_image = true,
					title = "Preview",
				},
			},
		},
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false, -- Closes auto-expanded directories when revealing
		},
	},
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = function()
--     local neo_tree_buf = vim.fn.bufname(vim.fn.bufnr())
--     if not vim.api.nvim_buf_get_option(0, "modified") and vim.bo.filetype ~= "neo-tree" then
--       local state = require("neo-tree.sources.manager").get_state("filesystem")
--       if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
--         -- require("no-tree.ui.renderer").close(state)
--         require("neo-tree.command").execute({ action = "close" })
--       end
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd("BufLeave", {
--   pattern = "*",
--   callback = function()
--     local bufname = vim.api.nvim_buf_get_name(0)
--     if bufname == "" then return end
--     local win = vim.api.nvim_get_current_win()
--     local buf = vim.api.nvim_win_get_buf(win)
--     local ft = vim.api.nvim_buf_get_option(buf, "filetype")
--     if ft == "neo-tree" then
--       vim.cmd("Neotree close")
--     end
--   end,
-- })

-- Formatter
require("conform").setup({
	format_on_save = { lsp_fallback = true, timeout_ms = 500 },
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		php = { "pint" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettier",
		"prettierd",
		"pint",
	},
})

-- Folding
require("plugins.ufo")

-- Git
require("plugins.git")

-- fzf
require("plugins.fzf")
