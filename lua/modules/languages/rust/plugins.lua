local plugins = {
	{
		'Saecki/crates.nvim',
		event = { "BufRead Cargo.toml" },
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('crates').setup({
				null_ls = {
					enabled = IsModuleEnabled('lsp'),
					name = "crates.nvim",
				},
			})

			if IsModuleEnabled('completion') then
				vim.api.nvim_create_autocmd("BufRead", {
					group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
					pattern = "Cargo.toml",
					callback = function()
						local cmp = require('cmp')
						cmp.setup.buffer({ sources = { { name = "crates" } } })
					end,
				})
			end
		end
	}
}

if IsModuleEnabled('lsp') then
	table.insert(plugins, {
		'mrcjkb/rustaceanvim',
		version = '^4',
		lazy = false,
		config = function()
			local lsp_utils = require('modules.lsp.utils')

			vim.g.rustaceanvim = {
				server = {
					on_attach = lsp_utils.on_attach
				}
			}
		end
	})
end

return plugins
