return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                hide_numbers = true,
                shade_filetypes = {},
                shade_terminals = true,
                shading_factor = 2,
                start_in_insert = true,
                insert_mappings = true,
                persist_size = true,
                direction = "horizontal",
                close_on_exit = true,
                shell = "fish",
                auto_scroll = true,
            })
            vim.api.nvim_create_augroup(
                "disable_folding_toggleterm",
                { clear = true }
            )

            vim.api.nvim_create_autocmd("FileType", {
                group = "disable_folding_toggleterm",
                pattern = "toggleterm",
                callback = function(ev)
                    local bufnr = ev.buf
                    vim.api.nvim_set_option_value(
                        "foldmethod",
                        "manual",
                        { --[[ buf = bufnr ]]
                        }
                    )
                    vim.api.nvim_set_option_value(
                        "foldtext",
                        "foldtext()",
                        { --[[ buf = bufnr ]]
                        }
                    )
                end,
            })
        end,
    },
}
