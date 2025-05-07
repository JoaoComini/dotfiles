return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    opts = {},
    config = function()
        local registry = require("mason-registry")

        local ensure_installed = {
            "goimports",
            "stylua",
        }

        registry.refresh(function()
            for _, name in pairs(ensure_installed) do
                local package = registry.get_package(name)
                if not registry.is_installed(name) then
                    package:install()
                else
                    package:check_new_version(function(success, result_or_err)
                        if success then
                            package:install({ version = result_or_err.latest_version })
                        end
                    end)
                end
            end
        end)

        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports" },
            },
            format_on_save = {
                lsp_format = "fallback",
            },
        })
    end,
}
