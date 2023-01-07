local use = require('packer').use

use({
	'romgrk/barbar.nvim',
	config = function()
		require('modules.tabs.config')
	end,
})
