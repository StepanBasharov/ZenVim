return {
    "stevearc/aerial.nvim",
    config = function()
        require("aerial").setup({ backends = { "treesitter", "lsp" } })
        vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>", { desc = "Toggle Outline" })
    end,
}
