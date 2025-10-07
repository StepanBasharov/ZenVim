-- bootstrap lazy.nvim (менеджер плагинов)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- последняя стабильная ветка
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- общие настройки
require("config.options")

-- загрузка плагинов
require("lazy").setup("plugins")

-- визуальные настройки
vim.cmd("colorscheme tokyonight")
