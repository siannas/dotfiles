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
