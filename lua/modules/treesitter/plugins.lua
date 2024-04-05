return {
	'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
	'haringsrob/nvim_context_vt',
	'nvim-treesitter/nvim-treesitter-textobjects',
	'JoosepAlviste/nvim-ts-context-commentstring',
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require('modules.treesitter.config')
		end
	}
}
