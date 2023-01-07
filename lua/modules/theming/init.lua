local use = require('packer').use

use({
	'EdenEast/nightfox.nvim',
	config = function()
		require('modules.theming.config')
	end,
})
