require("nagar")

-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
    local t = 0
    for _, v in pairs(bufs) do
        if v.name:match("NvimTree_") == nil then
            t = t + 1
        end
    end
    return t
end

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and
            vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil and
            modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0 then
            vim.cmd "quit"
        end
    end
})

vim.cmd [[
highlight NonText ctermfg=grey guifg=grey
    highlight SpecialKey ctermfg=grey guifg=grey
]]


-- Enable list mode to show whitespace characters
vim.opt.list = true

-- Customize the listchars option
vim.opt.listchars = {
    tab = '▸ ', -- Tab character
    space = '·', -- Space character
    trail = '·', -- Trailing space
    extends = '⟩', -- Character to show at the end of a line that extends beyond the window
    precedes = '⟨', -- Character to show at the beginning of a line that extends beyond the window
    -- eol = '↲', -- End-of-line character
}

vim.opt.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.opt.shell = '/usr/bin/fish'

function Format_buffer()
    vim.lsp.buf.format({ async = true })
end

-- Autocommand for InsertLeave (when you leave insert mode)
vim.cmd [[
    augroup AutoFormatOnComplete
        autocmd!
        autocmd InsertLeave * lua Format_buffer()
    augroup END
]]

-- Key mappings for ; and \n to format
vim.api.nvim_set_keymap('i', ';', ';<cmd>lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<CR>', '<CR><cmd>lua vim.lsp.buf.format({ async = true })<CR><CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- Key mappings for Ctrl+l and Ctrl+h to switch between windows
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })

-- Key mappings for Ctrl+PageDown and Ctrl+PageUp to cycle tabs
-- Normal mode mapping
vim.api.nvim_set_keymap('n', '<C-PageDown>', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-PageUp>', ':tabprevious<CR>', { noremap = true, silent = true })

-- Insert mode mapping
vim.api.nvim_set_keymap('i', '<C-PageDown>', '<Esc>:tabnext<CR>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-PageUp>', '<Esc>:tabprevious<CR>i', { noremap = true, silent = true })

-- Visual mode mapping
vim.api.nvim_set_keymap('v', '<C-PageDown>', '<Esc>:tabnext<CR>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-PageUp>', '<Esc>:tabprevious<CR>gv', { noremap = true, silent = true })

-- Command mode mapping
vim.api.nvim_set_keymap('c', '<C-PageDown>', '<C-C>:tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<C-PageUp>', '<C-C>:tabprevious<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<C-PageDown>', '<C-\\><C-N>:tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-PageUp>', '<C-\\><C-N>:tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nt', '<:tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nt', '<:tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nt', '<:tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nt', '<:tabnew<CR>', { noremap = true, silent = true })
