return {
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_view_method = "general"
            vim.g.vimtex_view_general_viewer = "okular"
            vim.g.vimtex_view_general_options =
                "--unique file:@pdf\\#src:@line@tex"
        end,
    },
    {
        "nvim-telescope/telescope-bibtex.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("bibtex")
        end,
    },
}
