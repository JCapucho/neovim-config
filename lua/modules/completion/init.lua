local use = require('packer').use

use({ 'hrsh7th/cmp-cmdline' })
use({ 'hrsh7th/cmp-buffer' })
use({ 'hrsh7th/cmp-path' })
use({
	'L3MON4D3/LuaSnip',
	requires = { { 'rafamadriz/friendly-snippets' }, { 'saadparwaiz1/cmp_luasnip' } }
})

local after = {
	'cmp-cmdline',
	'cmp-buffer',
	'cmp-path',
	'LuaSnip',
}

if IsModuleEnabled('lsp') then
	use({ 'hrsh7th/cmp-nvim-lsp' })
	table.insert(after, 'cmp-nvim-lsp')
	use({ 'hrsh7th/cmp-nvim-lsp-signature-help' })
	table.insert(after, 'cmp-nvim-lsp-signature-help')
end

use({
	'hrsh7th/nvim-cmp',
	after = after,
	config = function()
		require('modules.completion.config')
	end,
})
