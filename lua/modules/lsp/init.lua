local use = require('packer').use

use({
	'glepnir/lspsaga.nvim',
	config = function()
		require('modules.lsp.lspsaga')
	end
})
use({
	'jose-elias-alvarez/null-ls.nvim',
	requires = { 'nvim-lua/plenary.nvim' },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.completion.spell,
			},
		})
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
