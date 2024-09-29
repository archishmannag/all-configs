return {
    {
        "neovim/nvim-lspconfig",
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local config = require('mason-lspconfig')
            config.setup({
                ensure_installed = { "clangd" },
                automatic_installation = true
            })
            local on_attach = function(_, _)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            end
            config.setup_handlers({
                function(server_name) -- default handler (optional)
                    local capabilities = require('cmp_nvim_lsp').default_capabilities()
                    require("lspconfig")[server_name].setup {
                        on_attach = on_attach,
                        capabilities = capabilities
                    }
                end,
                ['clangd'] = function()
                    require('lspconfig').clangd.setup({
                        cmd = { 'clangd', '--fallback-style=none' },
                        init_options = {
                            fallbackFlags = { '--style=file' },
                        },
                    })
                end
            })
        end
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')


            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping(function(fallback)
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
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'nvim_lsp_signature_help' },
                }, {
                    { name = 'buffer' },
                })
            })
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    }
}
