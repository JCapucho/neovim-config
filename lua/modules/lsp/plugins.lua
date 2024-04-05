local plugins = {
	{
		'nvimtools/none-ls.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('modules.lsp.null-ls-config')
		end
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			require('modules.lsp.config')
		end,
	}
}

if IsModuleEnabled('treesitter') and IsModuleEnabled('icons') then
	-- LSPSaga provides some nice UI improvements for lsp but requires
	-- treesitter and icons to be enabled
	table.insert(plugins, {
		'nvimdev/lspsaga.nvim',
		branch = "main",
		config = function()
			require('modules.lsp.lspsaga')
		end,
	})
end

return plugins
