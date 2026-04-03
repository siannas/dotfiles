vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "NeoTreeTabActiveV1", {
			fg = "#FFA500",
			bg = "NONE",
			ctermfg = 3,
			ctermbg = "NONE",
			bold = true,
		})
	end,
})
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
	buffers = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		bind_to_cwd = false,
		window = {
			-- mappings = {
			--   ["bd"] = "buffer_delete",
			-- },
		},
	},
	source_selector = {
		-- winbar = true,
		statusline = true,
		tabs_layout = "start",
		sources = {
			{ source = "filesystem" },
			{ source = "buffers" },
		},
		-- highlight_tab = "Search", -- string
		highlight_tab_active = "NeoTreeTabActiveV1", -- string
	},
})
