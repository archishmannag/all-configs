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
vim.api.nvim_set_keymap('i', '<CR>', '<CR><cmd>lua vim.lsp.buf.format({ async = true })<CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
