return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup({
                layouts = {
                    {
                        elements = {
                            "scopes",
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 0.33,
                        position = "left",
                    },
                    {
                        elements = { "repl", "console" },
                        size = 0.27,
                        position = "bottom",
                    },
                },
                floating = { border = "rounded" },
            })

            -- автоматическое открытие/закрытие UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- === KEYMAPS ===
            local opts = { noremap = true, silent = true, desc = "" }
            local map = function(lhs, rhs, desc)
                opts.desc = "Debug: " .. desc
                vim.keymap.set("n", lhs, rhs, opts)
            end

            map("<leader>dc", dap.continue, "Continue / Start")
            map("<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint")
            map("<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, "Set Conditional Breakpoint")
            map("<leader>dn", dap.step_over, "Step Over")
            map("<leader>di", dap.step_into, "Step Into")
            map("<leader>do", dap.step_out, "Step Out")
            map("<leader>dr", dap.repl.open, "Open REPL")
            map("<leader>dl", dap.run_last, "Run Last Debug Session")
            map("<leader>du", dapui.toggle, "Toggle UI")
            map("<leader>dq", dap.terminate, "Terminate Debug Session")

            vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "⚪", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "debugPC", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "📍", texthl = "", linehl = "", numhl = "" })
            -- Поддержка Go
            require("dap-go").setup()
        end,
        ft = { "go" },
    },
}

