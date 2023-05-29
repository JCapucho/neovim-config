local use = require('packer').use

use({
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('modules.dashboard.config')
	end,
	requires = { 'nvim-tree/nvim-web-devicons' }
})
