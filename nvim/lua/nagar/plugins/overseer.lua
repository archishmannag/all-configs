return {
    "stevearc/overseer.nvim",
    opts = {},
    config = function()
        require("overseer").setup({
            templates = { "builtin", "cpp_build-gcc", "cpp_build-clang" },
            template_dirs = { "overseer.template", "nagar.plugins.templates" },
        })
        vim.keymap.set("n", "<leader>or", vim.cmd.OverseerRun)
        vim.keymap.set("n", "<leader>ot", vim.cmd.OverseerToggle)
    end,
}
