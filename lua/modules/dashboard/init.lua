local use = require('packer').use

use({
	'glepnir/dashboard-nvim',
	config = function()
		require('modules.dashboard.config')
	end,
})
