local helper = require("nagar.config.helper")

return {
    cmd = {
        'JAVA_OPTS="-Djdk.xml.totalEntitySizeLimit=0"',
        "ltex-ls",
    },
    root_markers = {
        ".bib",
        ".tex",
    },
    settings = {
        enableTextCompletion = true,
        additionalRules = {
            enablePickyRules = true,
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
