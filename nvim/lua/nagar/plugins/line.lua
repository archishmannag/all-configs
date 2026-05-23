return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin-nvim",
                },
                sections = {
                    lualine_b = {
                        { "b:gitsigns_head", icon = "" },
                        "diff",
                        "diagnostics",
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                        },
                    },
                },
            })
        end,
    },
}
