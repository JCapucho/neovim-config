local use = require('packer').use

use({
	'TimUntersberger/neogit',
	requires = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('modules.neogit.config')
	end,
})
