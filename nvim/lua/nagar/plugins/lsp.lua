return {
    {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup()
            local config = require("mason-lspconfig")
            config.setup({
                ensure_installed = { "clangd" },
                automatic_installation = true,
            })

            -- Set the floating window background color
            vim.cmd(
                [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
            )
            vim.cmd(
                [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
            )

            local border = {
                { "╭", "FloatBorder" }, -- Top-left
                { "─", "FloatBorder" }, -- Top
                { "╮", "FloatBorder" }, -- Top-right
                { "│", "FloatBorder" }, -- Right
                { "╯", "FloatBorder" }, -- Bottom-right
                { "─", "FloatBorder" }, -- Bottom
                { "╰", "FloatBorder" }, -- Bottom-left
                { "│", "FloatBorder" }, -- Left
            }

            -- LSP settings (for overriding per client)
            local handlers = {
                ["textDocument/hover"] = vim.lsp.with(
                    vim.lsp.handlers.hover,
                    { border = border }
                ),
                ["textDocument/signatureHelp"] = vim.lsp.with(
                    vim.lsp.handlers.signature_help,
                    { border = border }
                ),
            }

            -- Keybindings
            local on_attach = function(_, _)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
                vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            end

            -- LSP setup (default + custom)
            config.setup_handlers({
                function(server_name) -- default handler (optional)
                    local capabilities =
                        require("cmp_nvim_lsp").default_capabilities()
                    require("lspconfig")[server_name].setup({
                        on_attach = on_attach,
                        handlers = handlers,
                        capabilities = capabilities,
                    })
                end,
                ["html"] = function()
                    --[[ local capabilities =
                        vim.lsp.protocol.make_client_capabilities()
                    capabilities.textDocument.completion.completionItem.snippetSupport =
                        true ]]
                    local capabilities =
                        require("cmp_nvim_lsp").default_capabilities()
                    capabilities.textDocument.completion.completionItem.snippetSupport =
                        true
                    require("lspconfig").html.setup({
                        filetypes = { "html", "htmldjango" },
                        init_options = {
                            configurationSection = {
                                "html",
                                "css",
                                "javascript",
                            },
                            embeddedLanguages = {
                                css = true,
                                javascript = true,
                            },
                            provideFormatter = true,
                        },
                        on_attach = on_attach,
                        capabilities = capabilities,
                        handlers = handlers,
                    })
                end,
                ["clangd"] = function()
                    local capabilities =
                        require("cmp_nvim_lsp").default_capabilities()
                    require("lspconfig").clangd.setup({
                        cmd = {
                            "clangd",
                            "--clang-tidy",
                            "--log=verbose",
                            "--background-index",
                            "--fallback-style=none",
                            "--experimental-modules-support",
                        },
                        init_options = {
                            -- fallbackFlags = { '--style=file' },
                            clangdFileStatus = true,
                            usePlaceholders = true,
                        },
                        on_new_config = function(new_config, _)
                            local status, cmake = pcall(require, "cmake-tools")
                            if status then
                                cmake.clangd_on_new_config(new_config)
                            end
                        end,
                        on_attach = on_attach,
                        handlers = handlers,
                        capabilities = capabilities,
                    })
                end,
                ["ts_ls"] = function()
                    local nvim_lsp = require("lspconfig")
                    nvim_lsp.ts_ls.setup({
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "javascript.jsx",
                            "typescript",
                            "typescriptreact",
                            "typescript.tsx",
                        },
                        root_dir = nvim_lsp.util.root_pattern(
                            "package.json",
                            "tsconfig.json",
                            "jsconfig.json",
                            ".git"
                        ),
                    })
                end,
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lsp_signature_help" },
                }, {
                    { name = "buffer" },
                }),
            })
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
