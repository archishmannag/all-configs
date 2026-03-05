vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
            local bufname =
                vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
                table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= "" then
                table.insert(floating_wins, w)
            end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(tree_wins) do
                vim.api.nvim_win_close(w, true)
            end
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        vim.keymap.set(
            "n",
            "<leader>cb",
            ":Telescope bibtex<CR>",
            { buffer = true, desc = "Search citations" }
        )
    end,
})

-- Automatically install and enable nvim-treesitter for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local treesitter = require("nvim-treesitter")
        local lang = vim.treesitter.language.get_lang(args.match)
        if vim.list_contains(treesitter.get_available(), lang) then
            if not vim.list_contains(treesitter.get_installed(), lang) then
                treesitter.install(lang):wait()
            end
            vim.treesitter.start(args.buf)

            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"
            vim.wo[0][0].foldlevel = 999
        end
    end,
    desc = "Enable nvim-treesitter and install parser if not installed",
})

-- Set the floating window background color
vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd(
    [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
)

-- Restart clangd after CMakeTools finishes a build
vim.api.nvim_create_autocmd("User", {
    pattern = "CMakeToolsBuildFinished",
    callback = function()
        -- Find all active clangd clients
        for _, client in ipairs(vim.lsp.get_clients()) do
            if client.name == "clangd" then
                vim.lsp.stop_client(client.id, true)
            end
        end

        -- Re-open buffer to trigger LSP reattach
        vim.defer_fn(function()
            vim.cmd("edit")
        end, 100)

        print("[cmake-tools] Build finished → clangd restarted")
    end,
})
