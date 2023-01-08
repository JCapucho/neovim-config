local use = require('packer').use

use({ 'p00f/nvim-ts-rainbow' })
use({ 'haringsrob/nvim_context_vt' })
use({ 'nvim-treesitter/playground' })
use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
use({ 'JoosepAlviste/nvim-ts-context-commentstring' })
use({
	'nvim-treesitter/nvim-treesitter',
	run = function()
		local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		ts_update()
	end,
	config = function()
		require('modules.treesitter.config')
	end
})
