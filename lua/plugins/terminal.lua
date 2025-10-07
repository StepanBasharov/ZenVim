return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      direction = "float", -- 'float', 'horizontal', 'vertical', 'tab'
      float_opts = {
        border = "curved", -- варианты: 'single', 'double', 'shadow', 'curved'
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
      },
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      close_on_exit = true,
    })

            vim.keymap.set(
      "n",                                 -- режим
      "<leader>t",                        -- сочетание
      "<cmd>ToggleTerm direction=float<CR>", -- действие
      { noremap = true, silent = true, desc = "Открыть терминал (float)" }
    )

    -- 🧠 Удобное закрытие/выход из терминала
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Выйти из терминала" })
  end,
}

