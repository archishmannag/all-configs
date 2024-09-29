return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -s. -bbuild -dcmake_build_type=release && cmake --build build --config release'
		},
	},
	config = function()
		local telescope = require('telescope')
		telescope.setup({})
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		telescope.load_extension('fzf')
	end
}
