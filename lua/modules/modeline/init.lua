local use = require('packer').use

use({
	'feline-nvim/feline.nvim',
	config = function()
		require('modules.modeline.config')
	end,
})
