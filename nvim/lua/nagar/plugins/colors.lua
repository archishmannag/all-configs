function ColourWindow(colour)
    --[[ colour = colour or "rose-pine-moon"
	vim.cmd.colorscheme(colour) ]]

    vim.cmd.colorscheme('nord')

    --[[ vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"}) ]]
end

return {
    'shaunsingh/nord.nvim',
    -- name = "rose-pine",
    config = function()
        --[[ require('rose-pine').setup({
            styles = {
                italic = false
            }
        }) ]]

        ColourWindow()
    end
}
