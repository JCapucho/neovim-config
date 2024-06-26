local plugins = {}

if IsModuleEnabled('lsp') then
	table.insert(plugins, {
		'mrcjkb/haskell-tools.nvim',
		version = '^3',
		ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
		config = function()
			local lsp_utils = require('modules.lsp.utils')

			vim.g.haskell_tools = {
				hls = {
					on_attach = function(client, bufnr, ht)
						lsp_utils.on_attach(client, bufnr)
					end,
				},
			}
		end
	})
end

return plugins
