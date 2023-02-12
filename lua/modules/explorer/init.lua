local use = require('packer').use

use({
	'stevearc/oil.nvim',
	config = function()
		require('modules.explorer.config')
	end
})
