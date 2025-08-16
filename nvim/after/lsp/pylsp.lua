local helper = require("nagar.config.helper")

return {
    root_markers = { ".pylintrc", "pyproject.toml", "*.py" },
    filetypes = { "python" },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                pylint = { enabled = true },
                flake8 = { enabled = false },
                mccabe = { enabled = false },
                pyflakes = { enabled = false },
                yapf = { enabled = true },
                black = { enabled = true, line_length = 88 },
                isort = { enabled = true, profile = "black" },
                jedi_completion = {
                    include_params = true,
                    enabled = true,
                    fuzzy = true,
                },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true, all_scopes = true },
                pylsp_mypy = { enabled = true },
            },
            configurationSources = { "pycodestyle" },
            -- Enable inlay hints for Python
            rope_completion = { enabled = true },
            rope_autoimport = { enabled = true },
        },
    },
    on_attach = helper.on_attach,
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        helper.capabilities
    ),
    -- on_new_config = function(new_config, _)
    --     local status, cmake = pcall(require, "cmake-tools")
    --     if status then
    --         cmake.pylsp_on_new_config(new_config)
    --     end
    -- end,
    single_file_support = true,
    autostart = true,
}
