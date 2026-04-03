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
