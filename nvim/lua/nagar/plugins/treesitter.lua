return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                modules = {},
                ignore_install = {},
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = "all",

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                refactor = {
                    smart_rename = {
                        enable = true,
                        -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
                        keymaps = {
                            smart_rename = "grr",
                        },
                    },
                },
            })

            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"
            vim.wo[0][0].foldlevel = 999
        end,
    },
}
