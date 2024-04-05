return {
	'NeogitOrg/neogit',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('modules.neogit.config')
	end,
}
