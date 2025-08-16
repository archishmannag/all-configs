-- Inlay hints functionality
local function toggle_inlay_hints(bufnr)
    local buf = bufnr or vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })

    if not enabled then
        vim.notify("Inlay hints enabled", vim.log.levels.INFO)
    else
        vim.notify("Inlay hints disabled", vim.log.levels.INFO)
    end
end

-- Keybindings
local on_attach = function(_, _)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
    vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, {})
end

-- LSP setup (default + custom)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable inlay hints capability
capabilities.textDocument.inlayHint = {
    dynamicRegistration = true,
    resolveSupport = {
        properties = {
            "tooltip",
            "textEdits",
            "label.tooltip",
            "label.command",
        },
    },
}

return {
    on_attach = on_attach,
    capabilities = capabilities,
    toggle_inlay_hints = toggle_inlay_hints,
}
