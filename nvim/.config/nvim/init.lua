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

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"

require("config.colors")

require("config.keymaps")
