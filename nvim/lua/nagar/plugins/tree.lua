return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {
            hijack_cursor = true,
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            renderer = {
                highlight_modified = 'icon',
                highlight_opened_files = 'all',
                highlight_diagnostics = 'icon',
                indent_markers = { enable = true, },
                icons = { modified_placement = 'before', }
            },
            diagnostics = {
                enable = true,
            },
            modified = { enable = true },
        }
        vim.keymap.set('n', '<leader>t', vim.cmd.NvimTreeOpen)
        vim.keymap.set('n', '<leader>T', vim.cmd.NvimTreeClose)
    end,
}
