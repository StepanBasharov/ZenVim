return {
        {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

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

        -- 🟢 Go
        lspconfig.gopls.setup({
            on_attach = on_attach,
            capabilities = cmp_capabilities,
            settings = {
                gopls = {
                    analyses = { unusedparams = true, shadow = true },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })

        -- 🟡 Python (через Pyright)
        lspconfig.pyright.setup({
            on_attach = on_attach,
            capabilities = cmp_capabilities,
            settings = {
                python = {
                    analysis = {
                        autoImportCompletions = true,
                        typeCheckingMode = "basic", -- можно "strict"
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        -- 🧹 Ruff LSP (быстрая диагностика и автофикс)
        lspconfig.ruff_lsp.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                -- Ruff не форматирует — отключим форматтер, если есть black/isort
                client.server_capabilities.documentFormattingProvider = false
            end,
            capabilities = cmp_capabilities,
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
    "onsails/lspkind-nvim",
    "kristijanhusak/vim-dadbod-completion", -- 👈 добавь это
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
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
          vim_item.menu = ({
            buffer = "[Buf]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            path = "[Path]",
            cmdline = "[Cmd]",
            ["vim-dadbod-completion"] = "[DB]", -- 👈 красиво подпишем источник
          })[entry.source.name]
          return vim_item
        end,
      },
      experimental = {
        ghost_text = true,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    -- 🔍 Поиск
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })

    -- 💻 Командная строка
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "path" },
        { name = "cmdline" },
      },
    })

    -- 🧠 Настройка для SQL файлов
    cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
      sources = cmp.config.sources({
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      }),
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
                -- Go
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.diagnostics.golangci_lint,
                -- Python
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
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
} 
