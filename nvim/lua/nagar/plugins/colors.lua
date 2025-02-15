-- function ColourWindow(colour)
--     --[[ colour = colour or "rose-pine-moon"
-- 	vim.cmd.colorscheme(colour) ]]
--
--     vim.cmd.colorscheme('nord')
--
--     --[[ vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"}) ]]
-- end
--
-- return {
--     'shaunsingh/nord.nvim',
--     -- name = "rose-pine",
--     config = function()
--         --[[ require('rose-pine').setup({
--             styles = {
--                 italic = false
--             }
--         }) ]]
--
--         ColourWindow()
--     end
-- }
-- return {
--     "samharju/synthweave.nvim",
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000,
--     config = function()
--         vim.cmd.colorscheme("synthweave")
--         -- transparent version
--         -- vim.cmd.colorscheme("synthweave-transparent")
--     end
-- }
return {
    'marko-cerovac/material.nvim',
    config = function()
        require('material').setup({
            contrast = {
                terminal = true,                     -- Enable contrast for the built-in terminal
                sidebars = false,                    -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                floating_windows = false,            -- Enable contrast for floating windows
                cursor_line = true,                  -- Enable darker background for the cursor line
                lsp_virtual_text = true,             -- Enable contrasted background for lsp virtual text
                non_current_windows = false,         -- Enable contrasted background for non-current windows
                popup_menu = false,
                filetypes = { 'dapui_breakpoints' }, -- Specify which filetypes get the contrasted (darker) background
            },

            styles = { -- Give comments style such as bold, italic, underline etc.
                comments = { italic = true },
                strings = { --[[ bold = true ]] },
                keywords = { --[[ underline = true ]] },
                functions = { bold = true, },
                variables = {},
                operators = {},
                types = {},
            },

            plugins = { -- Uncomment the plugins that you use to highlight them
                -- Available plugins:
                -- "coc",
                -- "colorful-winsep",
                "dap",
                -- "dashboard",
                -- "eyeliner",
                -- "fidget",
                -- "flash",
                "gitsigns",
                -- "harpoon",
                -- "hop",
                -- "illuminate",
                -- "indent-blankline",
                -- "lspsaga",
                -- "mini",
                -- "neogit",
                -- "neotest",
                -- "neo-tree",
                -- "neorg",
                -- "noice",
                "nvim-cmp",
                -- "nvim-navic",
                "nvim-tree",
                "nvim-web-devicons",
                -- "rainbow-delimiters",
                -- "sneak",
                "telescope",
                -- "trouble",
                -- "which-key",
                "nvim-notify",
            },

            disable = {
                colored_cursor = false, -- Disable the colored cursor
                borders = false,        -- Disable borders between vertically split windows
                background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
                term_colors = false,    -- Prevent the theme from setting terminal colors
                eob_lines = false       -- Hide the end-of-buffer lines
            },

            high_visibility = {
                lighter = false, -- Enable higher contrast text for lighter style
                darker = false   -- Enable higher contrast text for darker style
            },

            lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

            async_loading = true,      -- Load parts of the theme asynchronously for faster startup (turned on by default)

            custom_colors = nil,       -- If you want to override the default colors, set this to a function

            custom_highlights = {},    -- Overwrite highlights with your own
        })
        vim.cmd.colorscheme('material')
        vim.g.material_style = 'deep ocean'
    end
}
