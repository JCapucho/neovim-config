local use = require('packer').use

use({
	'mfussenegger/nvim-jdtls',
	ft = 'java',
	config = function()
		require('modules.languages.java.config')
	end
})
