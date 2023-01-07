local use = require('packer').use

local after = {}

if IsModuleEnabled('completion') then
	table.insert(after, 'cmp-nvim-lsp')
end

use({
	'neovim/nvim-lspconfig',
	after = after,
	config = function()
		require('modules.lsp.config')
	end,
})
