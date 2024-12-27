return {
    'stevearc/overseer.nvim',
    opts = {},
    config = function()
        require('overseer').setup({
            templates = { 'builtin', 'cpp_build' },
            template_dirs = { 'overseer.template', 'nagar.plugins.templates' }
        })
        vim.keymap.set('n', '<leader>o', vim.cmd.OverseerRun)
    end,

}
