local use = require('packer').use

use({ 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git' })
use({ 'haringsrob/nvim_context_vt' })
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
