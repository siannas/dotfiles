require("lualine").setup({
	options = {
		disabled_filetypes = {
			statusline = { "neo-tree" },
			tabline = { "neo-tree" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diagnostics" },
		lualine_c = {
			{
				"filename",
				path = 1,
			},
		},
		lualine_x = { "filetype" },
		lualine_y = {},
		lualine_z = {},
	},
})
