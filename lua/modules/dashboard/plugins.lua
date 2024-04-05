return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('modules.dashboard.config')
	end,
	dependencies = { 'nvim-tree/nvim-web-devicons' }
}
