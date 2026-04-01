local vim = vim

require("plugins.test")

require("plugins")

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- silent! colorscheme seoul256
vim.cmd.colorscheme("pixel")

require("config.keymaps")
