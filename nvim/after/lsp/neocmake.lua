local helper = require("nagar.config.helper")
local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true

return {
    capabilities = vim.tbl_deep_extend("force", {}, cap, helper.capabilities),
    settings = {
        neocmake = {
            cmakePath = "cmake",
            cmakeArgs = {},
            buildDirectory = "${workspaceFolder}/build",
            buildType = "Debug",
            configureOnOpen = true,
            diagnostics = {
                enable = true,
                onSave = true,
                onBuild = true,
            },
            formatting = {
                enable = true,
            },
            pathCompletion = {
                enable = true,
            },
        },
    },
    on_attach = helper.on_attach,
}
