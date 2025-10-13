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
vim.keymap.set({ "n", "v" }, "<leader>c", '"+d', { noremap = true, silent = true, desc = "Вырезать" })
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true, silent = true, desc = "Вставить" })
vim.keymap.set("n", "<leader>sl", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>sf", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Показать ошибку/хинт" })
vim.opt.spell = true
vim.opt.spelllang = { "en", "ru" }
local signs = {
    Error = "",
    Warn  = "",
    Info  = "",
    Hint  = "",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Настройка diagnostics через современный API
vim.diagnostic.config({
    virtual_text = true,   -- текст прямо в строке
    signs = true,          -- отображать иконки
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
