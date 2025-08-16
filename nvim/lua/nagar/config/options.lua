vim.g.mapleader = " "

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shell = "/usr/bin/fish"
vim.o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.fileencoding = "utf-8" -- the encoding written to a file
vim.o.mouse = "a"
vim.o.mousescroll = "ver:15,hor:2"
vim.o.winborder = "rounded"

vim.filetype.add({
    extension = {
        ["http"] = "http",
    },
})

vim.diagnostic.config({
    -- virtual_text = true,
    virtual_lines = {
        current_line = true,
    },
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
