local helper = require("nagar.config.helper")
helper.capabilities.textDocument.completion.completionItem.snippetSupport = true
return {
    root_markers = {},
    filetypes = { "html", "htmldjango" },
    settings = {},
    on_attach = helper.on_attach,
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        helper.capabilities
    ),
}
