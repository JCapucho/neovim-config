return {
	{
		'nvim-telescope/telescope.nvim',
		name = 'telescope',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('modules.telescope.config')
		end
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		config = function()
			require('telescope').load_extension('fzf')
		end
	},
	{
		'debugloop/telescope-undo.nvim',
		config = function()
			require("telescope").load_extension("undo")
		end
	}
}
