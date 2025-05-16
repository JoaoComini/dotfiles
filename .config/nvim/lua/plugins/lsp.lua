return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp"
    },
    config = function()
        local cmp = require("blink.cmp")

        local capabilities = cmp.get_lsp_capabilities()

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        require("mason-lspconfig").setup({
            ensure_installed = { "gopls", "lua_ls", "sqls", "clangd" },
        })
    end,
}
