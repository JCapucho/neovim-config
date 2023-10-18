local use = require('packer').use

use({
	'freddiehaddad/feline.nvim',
	config = function()
		require('modules.modeline.config')
	end,
})
