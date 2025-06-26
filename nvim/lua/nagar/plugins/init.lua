return {
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
            vim.o.undofile = true
        end,
    },
    {
        "echasnovski/mini.animate",
        config = function()
            require("mini.animate").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
            vim.keymap.set("n", "<leader>m", vim.cmd.Mason)
        end,
    },
    {
        "L3MON4D3/LuaSnip",
    },
    {
        "saadparwaiz1/cmp_luasnip",
    },
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "stevearc/dressing.nvim",
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "github/copilot.vim",
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "rcarriga/nvim-notify",
        commit = "b5825cf9ee881dd8e43309c93374ed5b87b7a896",
        config = function()
            require("notify").setup({
                stages = "slide",
                timeout = 3000,
                background_colour = "#000000",
                render = "wrapped-default",
                merge_duplicates = true,
            })
            vim.notify = require("notify")
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "andweeb/presence.nvim",
        config = function()
            require("presence").setup({
                auto_update = true,
                neovim_image_text = "The One True Text Editor",
                main_image = "neovim",
                show_time = true,

                -- Rich Presence text options
                editing_text = "Editing %s",
                file_explorer_text = "Browsing %s",
                git_commit_text = "",
                plugin_manager_text = "Managing plugins",
                reading_text = "Reading %s",
                workspace_text = "Working on %s",
                line_number_text = "Line %s out of %s",
            })
        end,
    },
}
