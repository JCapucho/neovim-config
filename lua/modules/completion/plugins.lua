local cmp_plugins = {
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'f3fora/cmp-spell',
	'hrsh7th/cmp-emoji',
	{
		'L3MON4D3/LuaSnip',
		build = "make install_jsregexp",
		dependencies = { 'rafamadriz/friendly-snippets', 'saadparwaiz1/cmp_luasnip' }
	},
	'onsails/lspkind.nvim',
}

if IsModuleEnabled('lsp') then
	table.insert(cmp_plugins, 'hrsh7th/cmp-nvim-lsp')
end

return {
	{
		'hrsh7th/nvim-cmp',
		dependencies = cmp_plugins,
		config = function()
			require('modules.completion.config')
		end,
	}
}
