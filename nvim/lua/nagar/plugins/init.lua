return {
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
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
    }
}
