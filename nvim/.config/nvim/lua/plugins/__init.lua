local vim = vim
local Plug = vim.fn["plug#"]

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

-- Powerline
Plug("nvim-lualine/lualine.nvim")

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

-- Inisialisasi sederhana untuk plugin yang membutuhkan setup
-- In your main init.lua, after plug#end()
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Your unified setup logic here

		require("trouble").setup({})

		-- Mason Tool & Lsp
		require("plugins.lsp")

		-- Noice & Notif
		require("plugins.noice")

		-- Konfigurasi nvim-cmp untuk autocomplete dan snippet (luasnip)
		require("plugins.cmp")

		-- Setup Nvim Tree
		require("plugins.neotree")

		-- Conform Formatter
		require("plugins.conform")

		-- Folding
		require("plugins.ufo")

		-- Git
		require("plugins.git")

		-- fzf
		require("plugins.fzf")

		-- Lua Line
		require("plugins.lualine")
	end,
})
