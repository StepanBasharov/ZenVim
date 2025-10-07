vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.updatetime = 300
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Скопировать" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { noremap = true, silent = true, desc = "Вырезать" })
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true, silent = true, desc = "Вставить" })
vim.keymap.set("n", "<leader>sl", vim.diagnostic.setloclist)
vim.opt.spell = true
vim.opt.spelllang = { "en", "ru" }
