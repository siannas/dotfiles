-- Tmux
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>")

-- Tab shortcut
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

-- Move current line down (Alt+J)
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("i", "<A-j>", ":m .+1<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1gv<CR>=gv", { noremap = true, silent = true })

-- Move current line up (Alt+K)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("i", "<A-k>", ":m .-2<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2gv<CR>=gv", { noremap = true, silent = true })

-- Fzf
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>fa", function()
	require("fzf-lua").files({
		prompt = "AllFiles> ",
		no_ignore = true, -- respect ".gitignore"  by default
	})
end, { desc = "Fzf Files (All including gitignored)" })

-- Neo Tree
vim.keymap.set("n", "<leader>w", ":Neotree toggle<cr>", { desc = "Toggle Neo-Tree", silent = true })
vim.keymap.set("n", "<leader>b", ":Neotree buffers toggle<cr>", { desc = "Toggle Neo-Tree Buffers", silent = true })

-- Yank relative path with y p
vim.keymap.set("o", "p", function()
	local name = vim.api.nvim_buf_get_name(0)
	if name == "" then
		vim.notify("No file name for this buffer", vim.log.levels.WARN)
		return ""
	end
	local path = vim.fn.expand("%:.") -- relative path
	vim.fn.setreg("+", path)
	vim.fn.setreg('"', path)
	vim.notify("Yanked: " .. path)
	return ""
end, { expr = true, desc = "Yank relative file path" })

-- Yank absolute path with y P
vim.keymap.set("o", "P", function()
	local name = vim.api.nvim_buf_get_name(0)
	if name == "" then
		vim.notify("No file name for this buffer", vim.log.levels.WARN)
		return ""
	end
	local path = vim.fn.expand("%:p") -- absolute path
	vim.fn.setreg("+", path)
	vim.fn.setreg('"', path)
	vim.notify("Yanked: " .. path)
	return ""
end, { expr = true, desc = "Yank absolute file path" })
