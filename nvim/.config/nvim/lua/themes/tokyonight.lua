require("tokyonight").setup({
	-- use the night style
	style = "night",
	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	on_colors = function(colors)
		colors.bg = "#282828"
		colors.bg_dark = "#282828"
		colors.bg_dark1 = "#282828"
		colors.bg_highlight = "#59534e"
	end,
})
