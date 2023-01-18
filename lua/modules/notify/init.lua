local use = require('packer').use

use({
	'vigoux/notifier.nvim',
	config = function()
		require('modules.notify.config')
	end
})
