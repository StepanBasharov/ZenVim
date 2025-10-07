return {
    {
        "numToStr/Comment.nvim",
        config = function()
            local status_ok, comment = pcall(require, "Comment")
            if not status_ok then
                return
            end

            comment.setup({
                padding = true,
                sticky = true
            })

            local api = require("Comment.api")

            -- Нормальный режим: комментируем строку и идем вниз
            vim.keymap.set('n', '<leader>]', function()
                api.toggle.linewise.current()   -- комментируем текущую строку
                vim.cmd('normal! j')             -- перемещаем курсор вниз на 1 строку
            end, { noremap = true, silent = true })

            -- Визуальный режим: комментируем выделение
            vim.keymap.set('v', '<leader>]', function()
                api.toggle.linewise(vim.fn.visualmode())
            end, { noremap = true, silent = true })
        end
    }
}


