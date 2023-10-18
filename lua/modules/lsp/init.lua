local use = require('packer').use

use({
	'nvimtools/none-ls.nvim',
	requires = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('modules.lsp.null-ls-config')
	end
})

local after = {}

if IsModuleEnabled('completion') then
	table.insert(after, 'cmp-nvim-lsp')
end

if IsModuleEnabled('languages.json') then
	table.insert(after, 'schemastore.nvim')
end

use({
	'neovim/nvim-lspconfig',
	after = after,
	config = function()
		require('modules.lsp.config')
	end,
})

if IsModuleEnabled('treesitter') and IsModuleEnabled('icons') then
	-- LSPSaga provides some nice UI improvements for lsp but requires
	-- treesitter and icons to be enabled
	use({
		'nvimdev/lspsaga.nvim',
		branch = "main",
		config = function()
			require('modules.lsp.lspsaga')
		end,
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" }
		}
	})
end
