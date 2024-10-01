return {
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        'echasnovski/mini.animate',
        version = '*',
        config = function()
            require('mini.animate').setup()
        end
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
            vim.keymap.set('n', '<leader>m', vim.cmd.Mason)
        end
    },
    {
        'L3MON4D3/LuaSnip',
    },
    {
        'saadparwaiz1/cmp_luasnip'
    },
    {
        'rafamadriz/friendly-snippets'
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        'github/copilot.vim'
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        config = function()
            require('Comment').setup()
        end
    },
    {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup({
                stages = "slide",
                timeout = 5000,
                background_colour = "#000000",
                text_colour = "#ffffff"
            })
            vim.notify = require('notify')
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'nord'
                }
            })
        end
    }
}
