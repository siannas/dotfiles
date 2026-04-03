vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE")
		-- vim.cmd("hi StatusLineNC guibg=NONE ctermbg=NONE")
	end,
})
