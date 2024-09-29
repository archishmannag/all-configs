return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {}
		vim.keymap.set('n', '<leader>t', vim.cmd.NvimTreeOpen)
		vim.keymap.set('n', '<leader>T', vim.cmd.NvimTreeClose)
	end,
}
