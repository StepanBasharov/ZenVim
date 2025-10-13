return {
        "VidocqH/lsp-lens.nvim",
        event = "VeryLazy",
        config = function()
            require("lsp-lens").setup({
                enable = true,
                include_declaration = false,
                sections = {
                    definition = false,
                    references = true,
                    implements = true, -- ключевой пункт
                    git_authors = true,
                },
                icons = {
                    references = "",
                    implements = "󰡱",
                },
            })
        end,
    }
