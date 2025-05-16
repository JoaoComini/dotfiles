return {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup({})

        local registry = require("mason-registry")

        local ensure_installed = {
            "goimports",
            "stylua",
            "cmakelang",
        }

        registry.refresh(function()
            for _, name in pairs(ensure_installed) do
                local package = registry.get_package(name)
                if not registry.is_installed(name) then
                    package:install()
                else
                    local current_version = package:get_installed_version()
                    local latest_version = package:get_latest_version()
                    if current_version ~= latest_version then
                        package:install({ version = latest_version })
                    end
                end
            end
        end)
    end,
}
