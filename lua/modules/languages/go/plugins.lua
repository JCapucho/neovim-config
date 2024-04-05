local plugins = {}

if IsModuleEnabled('lsp') then
	table.insert(plugins, {
		'ray-x/go.nvim',
		ft = { 'go', 'gomod' },
		config = function()
			local lsp_utils = require('modules.lsp.utils')

			require("go").setup({
				lsp_cfg = {
					on_attach = lsp_utils.on_attach,
				},
			})
		end
	})
end

return plugins
