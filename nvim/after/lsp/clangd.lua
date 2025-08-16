local helper = require("nagar.config.helper")
vim.tbl_deep_extend("force", helper.capabilities, {
    textDocument = {
        completion = {
            editsNearCursor = true,
        },
    },
    offsetEncoding = { "utf-8", "utf-16" },
})

local function has_compile_commands_json()
    local path = vim.loop.cwd() .. "/compile_commands.json"
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    end
    return false
end

return {
    cmd = {
        "/usr/bin/clangd",
        "--clang-tidy",
        "--fallback-style=none",
        has_compile_commands_json() and "--experimental-modules-support" or nil,
        "--all-scopes-completion",
        "--background-index",
        "--completion-parse=always",
        "--completion-style=bundled",
        "--enable-config",
        "--function-arg-placeholders=1",
        "--pch-storage=memory",
        "-j=8",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--compile-commands-dir=" .. vim.loop.cwd(),
    },
    root_markers = {
        ".c",
        ".cpp",
        ".cc",
        ".cxx",
        ".c++",
        ".hpp",
        ".hh",
        ".hxx",
        ".h++",
    },
    init_options = {
        fallbackFlags = { "-std=c++23" },
        clangdFileStatus = true,
        usePlaceholders = true,
    },
    settings = {
        clangd = {
            InlayHints = {
                Designators = true,
                Enabled = true,
                ParameterNames = true,
                DeducedTypes = true,
            },
        },
    },
    on_new_config = function(new_config, _)
        local status, cmake = pcall(require, "cmake-tools")
        if status then
            cmake.clangd_on_new_config(new_config)
        end
    end,
    on_attach = helper.on_attach,
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        helper.capabilities
    ),
}
