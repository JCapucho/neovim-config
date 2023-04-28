local use = require('packer').use

local after = { 'nvim-treesitter' }

if not IsModuleEnabled('treesitter') then
	error('Neorg requires the treesitter module')
end

if IsModuleEnabled('completion') then
	table.insert(after, 'nvim-cmp')
end

use({
	"nvim-neorg/neorg",
	after = after,
	run = ":Neorg sync-parsers",
	config = function()
		local modules = {
			["core.defaults"] = {},
			["core.export"] = {},
			["core.export.markdown"] = {}
		}

		if IsModuleEnabled('completion') then
			modules["core.completion"] = {
				config = { engine = 'nvim-cmp' }
			}
		end

		require("neorg").setup({
			load = modules
		})
	end
})
