local use = require('packer').use

use({ 'hrsh7th/cmp-cmdline' })
use({ 'hrsh7th/cmp-buffer' })
use({ 'hrsh7th/cmp-path' })
use({ 'f3fora/cmp-spell' })
use({
	'L3MON4D3/LuaSnip',
	requires = { { 'rafamadriz/friendly-snippets' }, { 'saadparwaiz1/cmp_luasnip' } }
})
use({ 'onsails/lspkind.nvim' })

local after = {
	'cmp-cmdline',
	'cmp-buffer',
	'cmp-path',
	'cmp-spell',
	'LuaSnip',
	'lspkind.nvim',
}

if IsModuleEnabled('lsp') then
	use({ 'hrsh7th/cmp-nvim-lsp' })
	table.insert(after, 'cmp-nvim-lsp')
end

use({
	'hrsh7th/nvim-cmp',
	after = after,
	config = function()
		require('modules.completion.config')
	end,
})
