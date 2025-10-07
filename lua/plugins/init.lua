return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "go", "gomod", "gowork", "gosum",
                "lua", "vim", "vimdoc", "bash",
                "python", "rust", "json", "yaml", "toml", "markdown",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local on_attach = function(client, bufnr)
                local buf_map = function(mode, lhs, rhs, desc)
                    if desc then desc = "LSP: " .. desc end
                    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
                end

                -- Go-to commands
                buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition")
                buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to Declaration")
                buf_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation")
                buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Go to References")
                buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Info")
                buf_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol")
            end
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = { unusedparams = true, shadow = true },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "onsails/lspkind-nvim", -- иконки
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" }, -- порядок колонок
                    format = function(entry, vim_item)
                        -- Добавляем иконки и цвет через lspkind
                        vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind

                        -- Пишем источник справа
                        vim_item.menu = ({
                            buffer = "[Buf]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            path = "[Path]",
                            cmdline = "[Cmd]",
                        })[entry.source.name]

                        return vim_item
                    end,
                },
                experimental = {
                    ghost_text = true,
                },
                window = {
                    completion = cmp.config.window.bordered(),    -- рамка вокруг completion
                    documentation = cmp.config.window.bordered(), -- рамка вокруг документации
                },
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
            sources = {
            { name = "buffer" }
             }
            })

            -- Командная строка
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "path" },
                    { name = "cmdline" },
                },
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.diagnostics.golangci_lint,
                },
            })
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            require("lspsaga").setup({
                ui = { border = "rounded" },
                symbol_in_winbar = { enable = true },
                lightbulb = {
                    enable = true,
                    sign = true,
                    debounce = 10,
                },
            })
        end,
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            -- lsp_keymaps = false,
            -- other options
        },
        config = function(lp, opts)
            require("go").setup(opts)
            local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require('go.format').goimports()
                end,
                group = format_sync_grp,
            })
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
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
    },
    {
        "barreiroleo/ltex_extra.nvim",
        ft = { "markdown", "tex" },
        dependencies = { "neovim/nvim-lspconfig" },
        -- yes, you can use the opts field, just I'm showing the setup explicitly
        config = function()
            require("ltex_extra").setup {
                your_ltex_extra_opts,
                server_opts = {
                    capabilities = your_capabilities,
                    on_attach = function(client, bufnr)
                        -- your on_attach process
                    end,
                    settings = {
                        ltex = {}
                    }
                },
            }
        end
    },
}
