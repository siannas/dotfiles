require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
		hover = {
			enabled = true, -- Pastikan hover diaktifkan
		},
	},
	cmdline = {
		view = "cmdline", -- moves command line to bottom
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = false, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	messages = {
		-- NOTE: If you enable messages, then the cmdline is enabled automatically.
		-- This is a current Neovim limitation.
		enabled = false, -- enables the Noice messages UI
		view = "notify", -- default view for messages
		view_error = "notify", -- view for errors
		view_warn = "notify", -- view for warnings
		view_history = "messages", -- view for :messages
		view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	},
	popupmenu = {
		enabled = true,
		backend = "cmp", -- Sets cmp as the backend for the popupmenu
		relative = "editor",
		position = { row = 8, col = "50%" },
		size = { width = 60, height = 10 },
		border = { style = "rounded", padding = { 0, 1 } },
		win_options = {
			winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
		},
	},
	views = {
		hover = {
			border = {
				style = "rounded", -- Opsi: "single", "double", "shadow"
				padding = { 0, 2 },
			},
			position = { row = 2, col = 2 }, -- Jarak dari kursor
			size = {
				max_width = 60,
				max_height = 20,
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
			},
		},
	},
})
