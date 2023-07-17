local use = require('packer').use

use({
	'NeogitOrg/neogit',
	requires = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('modules.neogit.config')
	end,
})
