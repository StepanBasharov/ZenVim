return {
    { "echasnovski/mini.icons", version = "*" },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }, 



    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({
                plugins = {
                    spelling = true,
                },
                window = {
                    border = "rounded",
                    position = "bottom",
                },
            })

            wk.register({
                { "<leader>f", group = "Find" },
                { "<leader>t", group = "Toggle" },
            })
        end,
    },

    -- Nvim-tree — файловый менеджер
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 35,
                    side = "left",
                },
                renderer = {
                    highlight_git = true,
                    highlight_opened_files = "name",
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                },
            })

            -- Клавиша для открытия/закрытия дерева
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
        end,
    },

    -- Bufferline — табы сверху
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    separator_style = "slant",
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = true,
                        },
                    },
                },
            })

            -- Клавиши переключения табов
            vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
            vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
            vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
            vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
            vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to the right" })
            vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to the left" })
        end,
    },

    -- Автоматическое закрытие скобок, кавычек и т.д.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({
                check_ts = true, -- поддержка treesitter
                fast_wrap = {},
            })
        end,
    },

    {
        "snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    pick = function(cmd, opts)
                        return LazyVim.pick(cmd, opts)()
                    end,
                    header = [[
╔───────────────────────────────────────────────────╗
│                                                   │
│ ███████╗███████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗ │
│ ╚══███╔╝██╔════╝████╗  ██║██║   ██║██║████╗ ████║ │
│   ███╔╝ █████╗  ██╔██╗ ██║██║   ██║██║██╔████╔██║ │
│  ███╔╝  ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ │
│ ███████╗███████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ │
│ ╚══════╝╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ │
│                                                   │
╚───────────────────────────────────────────────────╝
    [NeoVim build by gobur]
            ]],
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
            },
        },
    }
}
