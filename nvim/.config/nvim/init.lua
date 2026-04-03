local vim = vim

vim.call("plug#begin", "~/.local/share/nvim/plugged")
require("plugins.test")

require("plugins.__init")
require("themes.__init")
vim.call("plug#end")

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require("config.colors")

require("config.keymaps")
