require("config.options")
require("config.remap")
require("config.lazy")

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
        })
    end,
    group = highlight_group,
    pattern = "*",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "gd", function()
            vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "<leader>vws", function()
            vim.lsp.buf.workspace_symbol()
        end, opts)
        vim.keymap.set("n", "<leader>vf", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_prev()
        end, opts)
        vim.keymap.set("n", "<leader>va", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vr", function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
            vim.lsp.buf.rename()
        end, opts)
        vim.keymap.set({ "i", "n" }, "<C-h>", function()
            vim.lsp.buf.signature_help()
        end, opts)
    end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    callback = function(e)
        local tree = require('nvim-tree.api').tree

        -- Nothing to do if tree is not opened
        if not tree.is_visible() then
            return
        end

        tree.find_file({
            buf = e.buf,
            open = false,
            focus = false
        })
    end
})

-- Make :bd and :q behave as usual when tree is visible
vim.api.nvim_create_autocmd({ 'QuitPre' }, {
    callback = function()
        local tree = require('nvim-tree.api').tree

        -- Nothing to do if tree is not opened
        if not tree.is_visible() then
            return
        end

        -- How many focusable windows do we have? (excluding e.g. incline status window)
        local count = 0
        for _, id in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_config(id).focusable then
                count = count + 1
            end
        end

        -- We want to quit and only one window besides tree is left
        if count == 2 then
            vim.api.nvim_cmd({ cmd = 'qall' }, {})
        end
    end
})

vim.cmd([[filetype plugin on]])

vim.cmd([[colorscheme tokyonight]])
