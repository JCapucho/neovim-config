local use = require('packer').use

use({
	'nvim-telescope/telescope.nvim',
	as = 'telescope',
	requires = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('modules.telescope.config')
	end
})

use({
	'nvim-telescope/telescope-fzf-native.nvim',
	run = 'make',
	after = 'telescope',
	config = function()
		require('telescope').load_extension('fzf')
	end
})
use({
	'debugloop/telescope-undo.nvim',
	after = 'telescope',
	config = function()
		require("telescope").load_extension("undo")
	end
})
