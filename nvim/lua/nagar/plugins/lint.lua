return {
    {
        "mfussenegger/nvim-lint",
        dependencies = {
            "mason-org/mason.nvim",
        },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                markdown = { "markdownlint" },
                python = { "flake8", "pylint" },
                typescript = { "eslint_d" },
                javascript = { "eslint_d" },
                json = { "jsonlint" },
            }
            vim.api.nvim_create_autocmd(
                { "BufWritePost", "BufEnter", "InsertLeave" },
                {
                    callback = function()
                        lint.try_lint()
                    end,
                }
            )
        end,
    },
    {
        "rshkarin/mason-nvim-lint",
        dependencies = {
            "mfussenegger/nvim-lint",
            "mason-org/mason.nvim",
        },
        config = function()
            require("mason-nvim-lint").setup()
            vim.keymap.set("n", "<leader>m", vim.cmd.Mason)
        end,
    },
}
