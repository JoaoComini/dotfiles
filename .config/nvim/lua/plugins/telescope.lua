return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "^%.git/" },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        })

        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope git files" })
        vim.keymap.set("n", "<CS-p>", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set("n", "<leader>tb", builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>th", builtin.help_tags, { desc = "Telescope help tags" })
    end,
}
