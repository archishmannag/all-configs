local helper = require("nagar.config.helper")

return {
    root_markers = {
        ".bib",
        ".tex",
    },
    settings = {
        texlab = {
            build = {
                executable = "vimtex",
                args = {},
                onSave = true,
            },
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
            forwardSearch = {
                executable = "okular",
                args = {
                    "--unique",
                    "--synctex-forward",
                    "%l:1:%f",
                    "%p",
                },
            },
            latexFormatter = "tex-fmt",
            latexindent = {},
            bibtexFormatter = "texlab",
            formatterLineLength = 80,
        },
    },
    on_attach = helper.on_attach,
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        helper.capabilities
    ),
}
