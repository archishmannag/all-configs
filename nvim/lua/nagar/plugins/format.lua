return {
    {
        "stevearc/conform.nvim",
        dependencies = {
            "mason-org/mason.nvim",
        },
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    cpp = { "clang-format" },
                    c = { "clang-format" },
                    python = { "black" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    json = { "prettier" },
                    markdown = { "prettier" },
                    html = { "prettier" },
                    yaml = { "prettier" },
                    tex = { "tex-fmt" },
                },
                format_on_save = {
                    lsp_format = "fallback",
                    timeout_ms = 500,
                },
            })
            vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
        end,
    },
    {
        "zapling/mason-conform.nvim",
        dependencies = {
            "stevearc/conform.nvim",
            "mason-org/mason.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-conform").setup()
            vim.keymap.set("n", "<leader>m", vim.cmd.Mason)
        end,
    },
}
