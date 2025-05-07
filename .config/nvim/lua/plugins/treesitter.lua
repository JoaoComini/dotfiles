return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "go", "javascript", "html", "sql" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
