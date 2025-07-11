return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports" },
                sql = { "sql_formatter" },
            },
            format_on_save = {
                lsp_format = "fallback",
            },
        })
    end,
}
