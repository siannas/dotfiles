local vim = vim
local Plug = vim.fn["plug#"]

-- Load Themes
Plug("folke/tokyonight.nvim")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
	-- Your unified setup logic here
    
	require("themes.tokyonight")

	-- Set Theme
	vim.cmd([[colorscheme tokyonight]])

  end
})

