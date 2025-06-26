require("nagar")

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

-- Enable list mode to show whitespace characters
vim.opt.list = true

-- Customize the listchars option
vim.opt.listchars = {
    tab = "▸ ", -- Tab character
    space = "·", -- Space character
    trail = "·", -- Trailing space
    extends = "⟩", -- Character to show at the end of a line that extends beyond the window
    precedes = "⟨", -- Character to show at the beginning of a line that extends beyond the window
    -- eol = '↲', -- End-of-line character
}

vim.opt.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.opt.shell = "/usr/bin/fish"

-- Key mappings for Ctrl+(hjkl) to switch between windows
vim.api.nvim_set_keymap(
    "n",
    "<C-l>",
    "<C-w>l",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-h>",
    "<C-w>h",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-j>",
    "<C-w>j",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-k>",
    "<C-w>k",
    { noremap = true, silent = true }
)

-- Key mappings for Ctrl+PageDown and Ctrl+PageUp to cycle tabs
-- Normal mode mapping
vim.api.nvim_set_keymap(
    "n",
    "<C-PageDown>",
    ":tabnext<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-PageUp>",
    ":tabprevious<CR>",
    { noremap = true, silent = true }
)

-- Insert mode mapping
vim.api.nvim_set_keymap(
    "i",
    "<C-PageDown>",
    "<Esc>:tabnext<CR>i",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "i",
    "<C-PageUp>",
    "<Esc>:tabprevious<CR>i",
    { noremap = true, silent = true }
)

-- Visual mode mapping
vim.api.nvim_set_keymap(
    "v",
    "<C-PageDown>",
    "<Esc>:tabnext<CR>gv",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "v",
    "<C-PageUp>",
    "<Esc>:tabprevious<CR>gv",
    { noremap = true, silent = true }
)

-- Command mode mapping
vim.api.nvim_set_keymap(
    "c",
    "<C-PageDown>",
    "<C-C>:tabnext<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "c",
    "<C-PageUp>",
    "<C-C>:tabprevious<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "t",
    "<C-PageDown>",
    "<C-\\><C-N>:tabnext<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "t",
    "<C-PageUp>",
    "<C-\\><C-N>:tabprevious<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>nt",
    "<:tabnew<CR>",
    { noremap = true, silent = true }
)

vim.filetype.add({
    extension = {
        ["http"] = "http",
    },
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
