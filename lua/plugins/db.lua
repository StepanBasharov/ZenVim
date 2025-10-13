return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },

  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,

  keys = {
    { "<leader>sd", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
    { "<leader>sa", "<cmd>DBUIAddConnection<CR>", desc = "Add DB Connection" },
    { "<leader>sb", "<cmd>DBUIFindBuffer<CR>", desc = "Find DB Buffer" },
  },
}

