return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
    {
        "saghen/blink.indent",
        --- @module 'blink.indent'
        --- @type blink.indent.Config
        opts = {},
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
            vim.o.undofile = true
        end,
    },
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({
                snippet_engine = "luasnip",
            })

            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap(
                "n",
                "<Leader>k",
                ":lua require('neogen').generate()<CR>",
                opts
            )
        end,
    },
    {
        "echasnovski/mini.animate",
        config = function()
            require("mini.animate").setup()
        end,
    },
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
            vim.keymap.set("n", "<leader>m", vim.cmd.Mason)
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
        dependencies = {
            "rafamadriz/friendly-snippets",
            "benfowler/telescope-luasnip.nvim",
        },
        config = function(_, opts)
            if opts then
                require("luasnip").config.setup(opts)
            end
            vim.tbl_map(function(type)
                require("luasnip.loaders.from_" .. type).lazy_load()
            end, { "vscode", "snipmate", "lua" })
            -- friendly-snippets - enable standardized comments snippets
            require("luasnip").filetype_extend("typescript", { "tsdoc" })
            require("luasnip").filetype_extend("javascript", { "jsdoc" })
            require("luasnip").filetype_extend("lua", { "luadoc" })
            require("luasnip").filetype_extend("python", { "pydoc" })
            require("luasnip").filetype_extend("rust", { "rustdoc" })
            require("luasnip").filetype_extend("cs", { "csharpdoc" })
            require("luasnip").filetype_extend("java", { "javadoc" })
            require("luasnip").filetype_extend("c", { "cdoc" })
            require("luasnip").filetype_extend("cpp", { "cppdoc" })
            require("luasnip").filetype_extend("php", { "phpdoc" })
            require("luasnip").filetype_extend("kotlin", { "kdoc" })
            require("luasnip").filetype_extend("ruby", { "rdoc" })
            require("luasnip").filetype_extend("sh", { "shelldoc" })
        end,
    },
    {
        "saadparwaiz1/cmp_luasnip",
    },
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "stevearc/dressing.nvim",
        opts = {},
    },
    -- Enable for rendering image in Neovim, but not required now and does not work with Konsole as of now
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            processor = "magick_cli",
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "zbirenbaum/copilot.lua",
        config = function()
            -- local cmp = require("cmp")
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = false,
                        accept_word = "<M-Right>",
                        accept_line = "<M-C-Right>",
                        next = "<M-]>",
                        dismiss = "<C-]>",
                    },
                },
            })

            -- Conditional <Tab> mapping
            vim.keymap.set("i", "<Tab>", function()
                local copilot = require("copilot.suggestion")
                local ok_cmp, cmp = pcall(require, "cmp")

                if copilot.is_visible() then
                    copilot.accept()
                elseif ok_cmp and cmp.visible() then
                    cmp.confirm({ select = true })
                else
                    return "<Tab>"
                end
            end, { expr = true, silent = true })
        end,
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                stages = "slide",
                timeout = 3000,
                background_colour = "#000000",
                render = "wrapped-default",
                merge_duplicates = true,
            })
            vim.notify = require("notify")
        end,
    },
    {
        "folke/noice.nvim",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    hover = {
                        enabled = false,
                    },
                    signature = {
                        enabled = false,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "andweeb/presence.nvim",
        config = function()
            require("presence").setup({
                auto_update = true,
                neovim_image_text = "Neovim",
                main_image = "file",
                show_time = true,

                -- Rich Presence text options
                editing_text = "Editing %s",
                file_explorer_text = "Browsing %s",
                git_commit_text = "Getting gitty with it",
                plugin_manager_text = "Managing plugins",
                reading_text = "Reading %s",
                workspace_text = "Working on %s",
                line_number_text = "Line %s out of %s",
            })
        end,
    },
}
