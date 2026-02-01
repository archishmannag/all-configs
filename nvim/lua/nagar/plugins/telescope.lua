return {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.2.1",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
        },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                -- Add --hidden to ripgrep arguments so live_grep also searches hidden files
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden", -- include hidden files
                    "--glob",
                    "!**/.git/*", -- exclude .git folder
                },
            },
            pickers = {
                find_files = {
                    hidden = true, -- show hidden files in find_files picker
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--glob",
                        "!**/.git/*",
                    }, -- use ripgrep to find files including hidden
                },
            },
        })
        local builtin = require("telescope.builtin")
        vim.keymap.set(
            "n",
            "<leader>ff",
            builtin.find_files,
            { desc = "Telescope find files" }
        )
        vim.keymap.set(
            "n",
            "<leader>fg",
            builtin.live_grep,
            { desc = "Telescope live grep" }
        )
        telescope.load_extension("fzf")
    end,
}
